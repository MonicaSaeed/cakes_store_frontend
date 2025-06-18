import 'package:firebase_auth/firebase_auth.dart';

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