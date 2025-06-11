import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/components/navigation_bar.dart';
import 'features/auth/business/auth_cubit.dart';
import 'features/auth/data/repository/auth_repository.dart';
import 'features/auth/data/webservice/auth_webservice.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseAuth.instance.signOut(); // Ensure user is signed out on app start
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => AuthCubit(AuthRepository(AuthWebservice()))..getCurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthSuccess) {
          return const NavigationBarScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
