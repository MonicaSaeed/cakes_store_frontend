import 'package:cakes_store_frontend/features/auth/presentation/components/auth_divider.dart';
import 'package:cakes_store_frontend/features/auth/presentation/components/custom_password_textfield.dart';
import 'package:cakes_store_frontend/features/auth/presentation/components/social_auth_buttons.dart';
import 'package:cakes_store_frontend/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cakes_store_frontend/core/components/custom_elevated_button.dart';
import 'package:cakes_store_frontend/core/components/custom_text_field.dart';
import 'package:cakes_store_frontend/core/services/toast_helper.dart';
import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:cakes_store_frontend/features/auth/data/model/user_firebase_model.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animationController;
  final bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      final user = UserFirebaseModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        password: _passwordController.text.trim(),
      );
      context.read<AuthCubit>().registerUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ToastHelper.showToast(
                context: context,
                message: state.message,
                toastType: ToastType.error,
              );
            } else if (state is AuthVerificationEmailSent) {
              ToastHelper.showToast(
                context: context,
                message: state.message,
                toastType: ToastType.warning,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            } else if (state is AuthSuccessWithGoogle ||
                state is AuthSuccessWithFacebook) {
              ToastHelper.showToast(
                context: context,
                message: 'Logged in successfully',
                toastType: ToastType.success,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            }
          },
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    LightThemeColors.primary.withValues(alpha: 0.2),
                    LightThemeColors.primary.withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Create Account',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineLarge?.copyWith(
                                shadows: [
                                  Shadow(
                                    blurRadius: 4.0,
                                    color: Colors.black.withValues(alpha: 0.1),
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Create your account to get started',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 30),

                            // Form
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.2),
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
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      title: 'Username',
                                      hintText: 'Your username',
                                      controller: _nameController,
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: LightThemeColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      title: 'Email',
                                      hintText: 'you@example.com',
                                      controller: _emailController,
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: LightThemeColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      title: 'Phone',
                                      hintText: 'Your phone number',
                                      controller: _phoneController,
                                      prefixIcon: Icon(
                                        Icons.phone_outlined,
                                        color: LightThemeColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      title: 'Address',
                                      hintText: 'Your delivery address',
                                      controller: _addressController,
                                      prefixIcon: Icon(
                                        Icons.home_outlined,
                                        color: LightThemeColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    CustomPasswordTextfield(
                                      title: 'Password',
                                      hintText: 'Minimum 8 characters',
                                      controller: _passwordController,
                                      obscureText: !_isPasswordVisible,
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: LightThemeColors.primary,
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
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(
                                                        LightThemeColors
                                                            .primary,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                'Creating......',
                                                style: TextStyle(
                                                  color:
                                                      LightThemeColors.primary,
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
                                        textdata: 'Sign Up',
                                        onPressed: _onRegisterPressed,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            AuthDivider(text: 'Or sign up with'),
                            SocialAuthButtons(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account? ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 16),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Text(
                                        'Log in',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.displaySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
