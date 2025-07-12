import 'package:cakes_store_frontend/core/services/toast_helper.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';
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

    ToastHelper.showToast(
    context: context,
    message: "Account deleted successfully",
    toastType: ToastType.success,
      );
      
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const LoginScreen()),
    (route) => false,
  );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
     ToastHelper.showToast(
    context: context,
    message: "Please log in again to delete your account: $e",
    toastType: ToastType.error,
  );
    
    } else {
     ToastHelper.showToast(
      context: context,
      message: "Failed to Delete Account: $e",
      toastType: ToastType.error,
    );
    }
  }
}
