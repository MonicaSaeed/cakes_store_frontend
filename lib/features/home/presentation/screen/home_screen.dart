import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../auth/presentation/screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: const Text('logout'),
          ),
          Center(child: Text('Welcome to the Home Screen!')),
        ],
      ),
    );
  }
}
