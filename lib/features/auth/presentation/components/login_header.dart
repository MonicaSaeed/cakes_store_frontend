import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginHeader extends StatelessWidget {
  final AnimationController animationController;

  const LoginHeader({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        // Animated Cake Logo with Lottie
        Lottie.asset(
          'assets/animations/cake_animation.json',
          width: 180,
          height: 180,
          controller: animationController,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        // Welcome Text
        Column(
          children: [
            Text(
              'Welcome Back!',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black.withAlpha((0.1 * 255).toInt()),
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Log in to your Cakes Store account',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
