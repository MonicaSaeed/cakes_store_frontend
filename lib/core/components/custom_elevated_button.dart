import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.textdata,
    required this.onPressed,
    this.color,
    this.width,
    this.icon,
  });

  final String textdata;
  final VoidCallback onPressed;
  final Color? color;
  final int? width;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,
        label: Text(textdata),
      ),
    );
  }
}
