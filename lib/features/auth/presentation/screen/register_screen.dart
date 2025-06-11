import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_elevated_button.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/services/toast_helper.dart';
import '../../../../core/theme/theme_colors.dart';
import '../../business/auth_cubit.dart';
import '../../data/model/user_firebase_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ToastHelper.showToast(
              context: context,
              message: state.message,
              toastType: ToastType.error,
            );
          } else if (state is AuthVerificationEmailSent) {
            Navigator.pop(context);
            ToastHelper.showToast(
              context: context,
              message: state.message,
              toastType: ToastType.warning,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'Create an Account',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  CustomTextField(
                    title: 'Name*',
                    hintText: 'Enter your name',
                    controller: nameController,
                  ),
                  CustomTextField(
                    title: 'Email*',
                    hintText: 'Enter your email',
                    controller: emailController,
                  ),
                  CustomTextField(
                    title: 'Phone*',
                    hintText: 'Enter your phone number',
                    controller: phoneController,
                  ),
                  CustomTextField(
                    title: 'Address*',
                    hintText: 'Enter your address',
                    controller: addressController,
                  ),
                  CustomTextField(
                    title: 'Password*',
                    hintText: 'Enter your password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  state is AuthLoading
                      ? const CircularProgressIndicator()
                      : CustomElevatedButton(
                        textdata: 'Register',
                        icon: const Icon(Icons.app_registration),
                        color: LightThemeColors.primary,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final user = UserFirebaseModel(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              phone: phoneController.text.trim(),
                              address: addressController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            context.read<AuthCubit>().registerUser(user);
                          }
                        },
                      ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: LightThemeColors.primary),
                        ),
                      ],
                    ),
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
