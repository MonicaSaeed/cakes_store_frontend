import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;
  final double size;

  const SocialAuthButton({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.size = 36, // size of the icon
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: size * 0.7,
      icon: Image.asset(assetPath, width: size, height: size),
    );
  }
}
