import 'package:cakes_store_frontend/core/services/toast_helper.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(title: const Text("Login")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            ToastHelper.showToast(
              context: context,
              message: 'Login Successfully',
              toastType: ToastType.success,
            );
            Navigator.pushReplacementNamed(
              context,
              '/home',
            ); // route after login
          } else if (state is AuthFailure || state is AuthEmailNotVerified) {
            final msg =
                state is AuthFailure
                    ? state.message
                    : (state as AuthEmailNotVerified).message;
            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(SnackBar(content: Text(msg)));
            ToastHelper.showToast(
              context: context,
              message: msg,
              toastType: ToastType.error,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator:
                        (value) =>
                            value!.isEmpty ? "Please enter your email" : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? "Please enter your password"
                                : null,
                  ),
                  const SizedBox(height: 20),
                  state is AuthLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () => _onLoginPressed(context),
                        child: const Text("Login"),
                      ),
                  ElevatedButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        ),
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
