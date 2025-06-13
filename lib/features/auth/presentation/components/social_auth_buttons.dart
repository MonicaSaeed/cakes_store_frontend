import 'package:cakes_store_frontend/features/auth/business/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cakes_store_frontend/features/auth/presentation/components/social_auth_button.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialAuthButton(
          assetPath: 'assets/images/google.png',
          onPressed: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
        ),
        const SizedBox(width: 16),
        SocialAuthButton(
          assetPath: 'assets/images/facebook.png',
          onPressed: () {
            context.read<AuthCubit>().signInWithFacebook();
          },
        ),
      ],
    );
  }
}
