import 'package:cakes_store_frontend/features/auth/presentation/screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/toast_helper.dart';
import '../../business/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),

      // body: BlocConsumer(
      //   builder: (context, state) {
      //     print('Login state: $state');
      //     if (state is AuthLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is AuthFailure) {
      //       ToastHelper.showToast(
      //         context: context,
      //         message: state.message,
      //         toastType: ToastType.error,
      //       );
      //     } else if (state is AuthEmailNotVerified) {
      //       ToastHelper.showToast(
      //         context: context,
      //         message: state.message,
      //         toastType: ToastType.warning,
      //       );
      //     } else if (state is AuthSuccess) {
      //       final user = state.user;
      //       user.reload(); // Refresh Firebase user info
      //       final refreshedUser = FirebaseAuth.instance.currentUser;
      //
      //       if (refreshedUser != null && refreshedUser.emailVerified) {
      //         ToastHelper.showToast(
      //           context: context,
      //           message: 'Login successful!',
      //           toastType: ToastType.success,
      //         );
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => const RegisterScreen()),
      //         );
      //       } else {
      //         ToastHelper.showToast(
      //           context: context,
      //           message: 'Please verify your email before logging in.',
      //           toastType: ToastType.warning,
      //         );
      //         context.read<AuthCubit>().logoutUser();
      //       }
      //     }
      //     return Padding(
      //       padding: const EdgeInsets.all(16),
      //       child: Column(
      //         children: [
      //           TextField(
      //             controller: emailController,
      //             decoration: const InputDecoration(labelText: 'Email'),
      //           ),
      //           TextField(
      //             controller: passwordController,
      //             obscureText: true,
      //             decoration: const InputDecoration(labelText: 'Password'),
      //           ),
      //           const SizedBox(height: 20),
      //           ElevatedButton(
      //             onPressed: () {
      //               context.read<AuthCubit>().loginUser(
      //                 emailController.text.trim(),
      //                 passwordController.text.trim(),
      //               );
      //             },
      //             child: const Text('Login'),
      //           ),
      //           const SizedBox(height: 10),
      //           ElevatedButton(
      //             onPressed: () {
      //               // Navigator.push(
      //               //   context,
      //               //   MaterialPageRoute(builder: (context) => const RegisterScreen()),
      //               // );
      //               context.read<AuthCubit>().loginUser(
      //                 emailController.text.trim(),
      //                 passwordController.text.trim(),
      //               );
      //             },
      //             child: const Text('Register'),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      //   listener: (context, state) {},
      // ),
      // body: BlocListener<AuthCubit, AuthState>(
      //   listener: (context, state) async {
      //     print('Login state: $state');
      //     if (state is AuthFailure) {
      //       print('Login failure: ${state.message}');
      //       ToastHelper.showToast(
      //         context: context,
      //         message: state.message,
      //         toastType: ToastType.error,
      //       );
      //     } else if (state is AuthEmailNotVerified) {
      //       ToastHelper.showToast(
      //         context: context,
      //         message: state.message,
      //         toastType: ToastType.warning,
      //       );
      //     } else if (state is AuthSuccess) {
      //       final user = state.user;
      //       await user.reload(); // Refresh Firebase user info
      //       final refreshedUser = FirebaseAuth.instance.currentUser;
      //
      //       if (refreshedUser != null && refreshedUser.emailVerified) {
      //         ToastHelper.showToast(
      //           context: context,
      //           message: 'Login successful!',
      //           toastType: ToastType.success,
      //         );
      //         await Future.delayed(const Duration(seconds: 5));
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => const RegisterScreen()),
      //         );
      //       } else {
      //         ToastHelper.showToast(
      //           context: context,
      //           message: 'Please verify your email before logging in.',
      //           toastType: ToastType.warning,
      //         );
      //         context.read<AuthCubit>().logoutUser();
      //       }
      //     }
      //   },
      //
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: Column(
      //       children: [
      //         TextField(
      //           controller: emailController,
      //           decoration: const InputDecoration(labelText: 'Email'),
      //         ),
      //         TextField(
      //           controller: passwordController,
      //           obscureText: true,
      //           decoration: const InputDecoration(labelText: 'Password'),
      //         ),
      //         const SizedBox(height: 20),
      //         ElevatedButton(
      //           onPressed: () {
      //             context.read<AuthCubit>().loginUser(
      //               emailController.text.trim(),
      //               passwordController.text.trim(),
      //             );
      //           },
      //           child: const Text('Login'),
      //         ),
      //         const SizedBox(height: 10),
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const RegisterScreen(),
      //               ),
      //             );
      //           },
      //           child: const Text('Register'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          print('Login state: $state');
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthFailure) {
            ToastHelper.showToast(
              context: context,
              message: state.message,
              toastType: ToastType.error,
            );
          } else if (state is AuthEmailNotVerified) {
            ToastHelper.showToast(
              context: context,
              message: state.message,
              toastType: ToastType.warning,
            );
          } else if (state is AuthSuccess) {
            final user = state.user;
            user.reload(); // Refresh Firebase user info
            final refreshedUser = FirebaseAuth.instance.currentUser;

            if (refreshedUser != null && refreshedUser.emailVerified) {
              ToastHelper.showToast(
                context: context,
                message: 'Login successful!',
                toastType: ToastType.success,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            } else {
              ToastHelper.showToast(
                context: context,
                message: 'Please verify your email before logging in.',
                toastType: ToastType.warning,
              );
              context.read<AuthCubit>().logoutUser();
            }
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().loginUser(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
