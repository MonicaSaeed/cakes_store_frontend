import 'package:cakes_store_frontend/core/components/custom_elevated_button.dart';
import 'package:cakes_store_frontend/core/components/custom_text_field.dart';
import 'package:cakes_store_frontend/core/services/toast_helper.dart';
import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().loginUser(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            ToastHelper.showToast(
              context: context,
              message: 'Login Successfully',
              toastType: ToastType.success,
            );
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthFailure || state is AuthEmailNotVerified) {
            final msg =
                state is AuthFailure
                    ? state.message
                    : (state as AuthEmailNotVerified).message;
            ToastHelper.showToast(
              context: context,
              message: msg,
              toastType: ToastType.error,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      title: 'Email*',
                      hintText: 'Enter your email',
                      controller: _emailController,
                    ),
                    CustomTextField(
                      title: 'Password*',
                      hintText: 'Enter your password',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    state is AuthLoading
                        ? const CircularProgressIndicator()
                        : CustomElevatedButton(
                          textdata: 'Login',
                          icon: const Icon(Icons.login),
                          color: LightThemeColors.primary,
                          onPressed: () => _onLoginPressed(context),
                        ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Register',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: LightThemeColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
