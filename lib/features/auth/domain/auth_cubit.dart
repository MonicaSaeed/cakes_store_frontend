import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/user_firebase_model.dart';
import '../data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  AuthCubit(this._repository) : super(AuthInitial());

  User? get currentUser =>
      (state is AuthSuccess)
          ? (state as AuthSuccess).user
          : (state is AuthSuccessWithGoogle)
          ? (state as AuthSuccessWithGoogle).user
          : null;
  Future<void> getCurrentUser() async {
    emit(AuthLoadingCurrentUser());
    try {
      final user = await _repository.getCurrentUser();
      // final userfromMongo = await _repository.getUserFromMongo(user?.uid ?? '');
      if (user != null) {
        if (!user.emailVerified) {
          emit(
            AuthEmailNotVerified('Please verify your email before logging in.'),
          );
          return;
        } else {
          emit(AuthSuccess(user));
        }
      } else {
        emit(AuthLoggedOut());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> registerUser(UserFirebaseModel user) async {
    emit(AuthLoading());
    try {
      await _repository.registerUser(user);
      final currentUser = await _repository.getCurrentUser();
      if (currentUser != null) {
        emit(AuthRegistrationSuccess(currentUser));
        await _repository.sendVerificationEmail(currentUser);
        emit(
          AuthVerificationEmailSent(
            'Registration successful. Please verify your email before logging in.',
          ),
        );
      } else {
        emit(AuthFailure('User not found after registration.'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> loginUser(String email, String password) async {
    emit(AuthLoading());
    try {
      final credential = await _repository.loginUser(email, password);
      final user = credential.user;
      if (user != null) {
        if (user.emailVerified) {
          emit(AuthSuccess(user));
        } else {
          final currentUser = await _repository.getCurrentUser();
          await _repository.sendVerificationEmail(currentUser!);
          emit(
            AuthEmailNotVerified(
              'Your email is not verified. We’ve sent you another verification email.',
            ),
          );
        }
      } else {
        emit(AuthUserNotFound('User not found.'));
      }
    } catch (e) {
      print('Error in loginUser: $e');
      if (e.toString().trim() ==
          'Exception: Too many attempts. Please try again later.') {
        emit(
          AuthFailure("Your email is not verified. Please check your inbox."),
        );
      } else {
        emit(AuthFailure(e.toString()));
      }
    }
  }

  Future<void> logoutUser() async {
    emit(AuthLoading());
    try {
      await _repository.logoutUser();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _repository.sendPasswordResetEmail(email);
      emit(
        AuthPasswordResetEmailSent('Password reset email sent successfully.'),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address format.';
          break;
        default:
          errorMessage = 'Something went wrong. Please try again.';
      }

      emit(FailureSendPasswordResetEmail(errorMessage));
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred.'));
    }
  }

  Future<void> sendVerificationEmail(User user) async {
    emit(AuthLoading());
    try {
      await _repository.sendVerificationEmail(user);
      emit(AuthEmailNotVerified('Verification email sent successfully.'));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await _repository.signInWithGoogle();
      emit(AuthSuccessWithGoogle(user!));
    } catch (e) {
      emit(AuthFailureWithGoogle(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final user = await _repository.signInWithFacebook();
      emit(AuthSuccessWithFacebook(user!));
    } catch (e) {
      emit(AuthFailureWithFacebook(e.toString()));
    }
  }

  String parseErrorMessage(String error) {
    // Remove repeated "Exception:" if present
    return error.replaceAll(RegExp(r'Exception:\s*'), '').trim();
  }
}
