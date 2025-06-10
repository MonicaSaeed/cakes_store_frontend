import 'package:cakes_store_frontend/features/auth/data/model/user_firebase_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../webservice/auth_webservice.dart';

class AuthRepository {
  final AuthWebservice _authWebservice;
  AuthRepository(this._authWebservice);

  Future<User?> getCurrentUser() async {
    try {
      return await _authWebservice.getCurrentUser();
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  Future<void> registerUser(UserFirebaseModel user) async {
    try {
      final credential = await _authWebservice.registerUser(
        user.email,
        user.password,
      );
      final userData = UserFirebaseModel(
        uid: credential.user!.uid,
        email: credential.user!.email!,
        name: user.name,
        phone: user.phone,
        address: user.address,
      );
      // handel save user to mongoDB after registration
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception('Unexpected error during registration');
    }
  }

  Future<void> sendVerificationEmail(User user) async {
    try {
      if (!user.emailVerified) {
        await _authWebservice.sendVerificationEmail(user);
      } else {
        throw Exception('Email is already verified');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception('Failed to send verification email');
    }
  }

  Future<UserCredential> loginUser(String email, String password) async {
    try {
      return await _authWebservice.loginUser(email, password);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception('Unexpected error during login');
    }
  }

  Future<void> logoutUser() async {
    try {
      await _authWebservice.logoutUser();
    } catch (e) {
      throw Exception('Failed to log out: $e');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authWebservice.sendPasswordResetEmail(email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception('Failed to send password reset email');
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'This email is already in use.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'email-already-verified':
        return 'Email is already verified.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      default:
        return e.message ?? 'Authentication error occurred.';
    }
  }
}
