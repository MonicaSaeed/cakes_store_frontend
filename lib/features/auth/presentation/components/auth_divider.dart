import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  final String text;
  final Color? color;

  const AuthDivider({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: color ?? Colors.grey,
              thickness: 1,
              endIndent: 8,
            ),
          ),
          Text(
            'or',
            style: TextStyle(
              color: color ?? Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
          Expanded(
            child: Divider(
              color: color ?? Colors.grey,
              thickness: 1,
              indent: 8,
            ),
          ),
        ],
      ),
    );
  }
}
