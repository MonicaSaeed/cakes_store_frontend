import 'package:firebase_auth/firebase_auth.dart';

class AuthWebservice {
  AuthWebservice._internal();
  static final AuthWebservice _instance = AuthWebservice._internal();
  factory AuthWebservice() => _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> registerUser(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendVerificationEmail(User user) async {
    try {
      await user.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> loginUser(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }
}
