import 'package:cakes_store_frontend/features/auth/presentation/components/custom_password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cakes_store_frontend/core/components/custom_elevated_button.dart';
import 'package:cakes_store_frontend/core/components/custom_text_field.dart';
import 'package:cakes_store_frontend/core/services/toast_helper.dart';
import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isPasswordVisible;
  final void Function(BuildContext context) onLoginPressed;

  const LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isPasswordVisible,
    required this.onLoginPressed,
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.2 * 255).toInt()),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(4, 4),
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            spreadRadius: 2,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomTextField(
              title: 'Email',
              hintText: 'your@example.com',
              controller: widget.emailController,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: LightThemeColors.primary,
              ),
            ),
            SizedBox(height: 8),
            CustomPasswordTextfield(
              title: 'Password',
              hintText: 'your password',
              controller: widget.passwordController,
              obscureText: !widget.isPasswordVisible,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: LightThemeColors.primary,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(top: 8),
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  final email = widget.emailController.text.trim();
                  if (email.isEmpty) {
                    ToastHelper.showToast(
                      context: context,
                      message: 'Please enter your email address.',
                      toastType: ToastType.error,
                    );
                    return;
                  }
                  context.read<AuthCubit>().sendPasswordResetEmail(email);
                },
                child: Text(
                  'Forgot password?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (state is AuthLoading)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            LightThemeColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Logging in...',
                        style: TextStyle(
                          color: LightThemeColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              CustomElevatedButton(
                textdata: 'Login',
                onPressed: () => widget.onLoginPressed(context),
              ),
          ],
        ),
      ),
    );
  }
}
