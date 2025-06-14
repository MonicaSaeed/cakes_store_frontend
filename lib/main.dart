import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/components/navigation_bar.dart';
import 'core/services/preference_manager.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/auth/business/auth_cubit.dart';
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
      builder: (_, value, _) {
        return BlocProvider(
          create: (_) => AuthCubit(sl())..getCurrentUser(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'YumSlice',
            themeMode: value,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const AuthGate(),
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
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthSuccess) {
          return const NavigationBarScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
