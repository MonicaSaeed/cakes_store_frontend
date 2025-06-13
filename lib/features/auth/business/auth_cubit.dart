import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/model/user_firebase_model.dart';
import '../data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  AuthCubit(this._repository) : super(AuthInitial());

  Future<void> getCurrentUser() async {
    emit(AuthLoadingCurrentUser());
    try {
      final user = await _repository.getCurrentUser();
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
          emit(
            AuthEmailNotVerified('Please verify your email before logging in.'),
          );
        }
      } else {
        emit(AuthUserNotFound('User not found.'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
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
    print('ngrb sign in with facebook');

    try {
      final user = await _repository.signInWithFacebook();
      emit(AuthSuccessWithFacebook(user!));
    } catch (e) {
      emit(AuthFailureWithFacebook(e.toString()));
    }
  }
}
