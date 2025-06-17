import 'package:cakes_store_frontend/features/auth/data/model/user_firebase_model.dart';
import 'package:cakes_store_frontend/features/auth/data/model/user_mongo_model.dart';
import 'package:cakes_store_frontend/features/auth/data/webservice/user_mongo_webservice.dart';
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
      final mongoUser = UserMongoModel(
        uid: credential.user!.uid,
        email: credential.user!.email!,
        username: user.name,
        phoneNumber: user.phone,
        addresses: [user.address],
      );
      await UserMongoWebService().saveUserToMongo(mongoUser);

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

  Future<User?> signInWithGoogle() async {
    try {
      final userCredential = await _authWebservice.signInWithGoogle();

      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      final user = userCredential.user;
      if (isNewUser && user != null) {
        final mongoUser = UserMongoModel(
          uid: user.uid,
          email: user.email ?? '',
          username: user.displayName ?? user.email?.split('@')[0],
          phoneNumber: user.phoneNumber,
          addresses: [],
        );
        await UserMongoWebService().saveUserToMongo(mongoUser);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception("Google sign-in failed: $e");
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      final userCredential = await _authWebservice.signInWithFacebook();

      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      final user = userCredential.user;

      if (isNewUser && user != null) {
        final mongoUser = UserMongoModel(
          uid: user.uid,
          email: user.email ?? '',
          username: user.displayName ?? '',
          phoneNumber: user.phoneNumber ?? '',
          addresses: [],
        );
        await UserMongoWebService().saveUserToMongo(mongoUser);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception("Facebook sign-in failed: $e");
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      // User-related errors
      case 'user-not-found':
        return 'No account found with this email.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'user-token-expired':
        return 'Your session has expired. Please log in again.';

      // Password & credentials
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password. Please try again.';

      case 'weak-password':
        return 'Your password is too weak. Use at least 6 characters.';

      // Email issues
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'email-already-verified':
        return 'This email is already verified.';

      // Operation issues
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'requires-recent-login':
        return 'For security reasons, please log in again to continue.';

      // Network issues
      case 'network-request-failed':
        return 'Unable to connect. Please check your internet connection.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      // Default
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }

  Future<UserMongoModel?> getUserFromMongo(String uid) async {
    print('Fetching user from MongoDB with UID: $uid');

    try {
      return await UserMongoWebService().getUserByUid(uid);
    } catch (e) {
      throw Exception('Failed to get user from MongoDB: $e');
    }
  }
}
