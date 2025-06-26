import 'package:cakes_store_frontend/app_router.dart';
import 'package:cakes_store_frontend/core/services/service_locator.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_state.dart';
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
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (_) => AuthCubit(sl())..getCurrentUser(),
            ),
            BlocProvider<UserCubit>(create: (_) => UserCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'YumSlice',
            themeMode: value,
            theme: lightTheme,
            darkTheme: darkTheme,
            onGenerateRoute:
                (RouteSettings settings) => AppRouter().generateRoute(settings),
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
      builder: (context, authState) {
        if (authState is AuthLoadingCurrentUser || authState is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authState is AuthSuccess) {
          return BlocProvider<UserCubit>(
            create: (_) => UserCubit()..getUserByUid(authState.user.uid),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, userState) {
                if (userState is UserLoading || userState is UserInitial) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                if (userState is UserLoaded) {
                  return BlocProvider<FavCubit>(
                    create:
                        (_) =>
                            FavCubit(userId: userState.user.id)
                              ..loadAllFavourites(),
                    child: NavigationBarScreen(),
                  );

                  // return BlocProvider<FavCubit>(
                  //   create:
                  //       (_) =>
                  //           FavCubit(userId: userState.user.id)
                  //             ..loadAllFavourites(),
                  //   child: const NavigationBarScreen(),
                  // );
                }

                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Failed to load user."),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }

        return const LoginScreen();
      },
    );
  }
}

// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthCubit, AuthState>(
//       builder: (context, state) {
//         if (state is AuthLoadingCurrentUser || state is AuthInitial) {
//           return Scaffold(
//             body: const Center(child: CircularProgressIndicator()),
//           );
//         } else if (state is AuthSuccess) {
//           return MultiBlocProvider(
//             providers: [
//               BlocProvider<UserCubit>(
//                 create:
//                     (context) =>
//                         UserCubit()..getUserByUid(
//                           context.read<AuthCubit>().currentUser?.uid ?? '',
//                         ),
//               ),
//               BlocProvider<FavCubit>(
//                 create:
//                     (context) => FavCubit(
//                       userId: context.read<UserCubit>().currentUser?.id,
//                     )..loadAllFavourites(),
//               ),
//             ],
//             child: const NavigationBarScreen(),
//           );
//         } else {
//           return const LoginScreen();
//         }
//       },
//     );
//   }
// }
