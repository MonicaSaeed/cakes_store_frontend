import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> logout() async {
  await FirebaseAuth.instance.signOut();
  if(FirebaseAuth.instance.currentUser == null)
   {
    return true; 
  } 
  else {
    return false;
  }
}

Future<void> deleteAccount(BuildContext context) async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account deleted successfully')),
      );
      // Navigate to login or welcome screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in again to delete your account')),
      );
      // ممكن هنا توديه لصفحة إعادة تسجيل الدخول
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  }
}
