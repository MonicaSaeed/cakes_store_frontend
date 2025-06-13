import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // 🔁 Always prompt account picker by signing out first
    await googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) throw Exception("Google Sign-In aborted");

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) {
      print('Error facebook: ${result.message}');
      throw Exception("Facebook Sign-In failed: ${result.message}");
    }

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.tokenString);

    return await _auth.signInWithCredential(facebookAuthCredential);
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
