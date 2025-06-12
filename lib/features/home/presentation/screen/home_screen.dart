import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/business/auth_cubit.dart';
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
            onPressed: () async {
              await context.read<AuthCubit>().logoutUser();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false, // removes all previous routes
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
