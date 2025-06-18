import 'package:cakes_store_frontend/core/components/navigation_bar.dart';
import 'package:cakes_store_frontend/core/services/toast_helper.dart';
import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:cakes_store_frontend/features/auth/presentation/components/auth_divider.dart';
import 'package:cakes_store_frontend/features/auth/presentation/components/login_form.dart';
import 'package:cakes_store_frontend/features/auth/presentation/components/login_header.dart';
import 'package:cakes_store_frontend/features/auth/presentation/components/social_auth_buttons.dart';
import 'package:cakes_store_frontend/features/auth/presentation/screen/register_screen.dart';
import 'package:cakes_store_frontend/features/favorites/presentation/cubit/fav_cubit.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_cubit.dart';
import 'package:cakes_store_frontend/features/user_shared_feature/presentation/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  final bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccess ||
                state is AuthSuccessWithGoogle ||
                state is AuthSuccessWithFacebook) {
              ToastHelper.showToast(
                context: context,
                message: 'Login Successfully!',
                toastType: ToastType.success,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider<UserCubit>(
                        create:
                            (_) =>
                                UserCubit()..getUserByUid(
                                  context.read<AuthCubit>().currentUser?.uid ??
                                      '',
                                ),
                        child: BlocBuilder<UserCubit, UserState>(
                          builder: (context, userState) {
                            if (userState is UserLoading ||
                                userState is UserInitial) {
                              return const Scaffold(
                                body: Center(
                                  child: CircularProgressIndicator(),
                                ),
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
                            }
                            return Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Failed to load user data.',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                ),
              );
            } else if (state is AuthPasswordResetEmailSent) {
              ToastHelper.showToast(
                context: context,
                message: state.message,
                toastType: ToastType.success,
              );
            } else if (state is AuthFailure ||
                state is AuthEmailNotVerified ||
                state is AuthFailureWithGoogle ||
                state is AuthFailureWithFacebook) {
              String msg = 'An unknown error occurred';

              if (state is AuthFailure) {
                msg = state.message;
              } else if (state is AuthEmailNotVerified) {
                msg = state.message;
              } else if (state is AuthFailureWithGoogle) {
                msg = state.message;
              } else if (state is AuthFailureWithFacebook) {
                msg = state.message;
              }
              ToastHelper.showToast(
                context: context,
                message: msg,
                toastType: ToastType.error,
              );
            } else if (state is FailureSendPasswordResetEmail) {
              ToastHelper.showToast(
                context: context,
                message: state.message,
                toastType: ToastType.error,
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
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              LoginHeader(
                                animationController: _animationController,
                              ),
                              LoginForm(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                formKey: _formKey,
                                isPasswordVisible: _isPasswordVisible,
                                onLoginPressed: _onLoginPressed,
                              ),
                              const SizedBox(height: 20),
                              const AuthDivider(text: 'Or log in with'),
                              const SocialAuthButtons(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'Don’t have an account? ',
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
                                            builder:
                                                (context) =>
                                                    const RegisterScreen(),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
                                        child: Text(
                                          'Sign up',
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
