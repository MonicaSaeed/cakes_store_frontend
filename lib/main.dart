import 'package:cakes_store_frontend/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cakes_store_frontend/features/auth/data/webservice/auth_webservice.dart';
import 'package:cakes_store_frontend/features/auth/data/repository/auth_repository.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';

import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/core/services/preference_manager.dart';
import 'package:cakes_store_frontend/core/theme/dark_theme.dart';
import 'package:cakes_store_frontend/core/theme/light_theme.dart';
import 'package:cakes_store_frontend/core/theme/theme_controller.dart';
import 'package:cakes_store_frontend/core/components/navigation_bar.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PreferencesManager().init();
  await ThemeController().init();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (_, themeMode, __) {
        return BlocProvider(
          create: (_) => AuthCubit(AuthRepository(AuthWebservice()))..getCurrentUser(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'YumSlice',
            themeMode: themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: AuthGate(),
          ),
        );
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingCurrentUser || state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthSuccess) {
          return const NavigationBarScreen(); // Where ProfileScreen is accessible
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
