import 'package:cakes_store_frontend/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title.replaceAll('*', ''),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                if (title.contains('*'))
                  TextSpan(
                    text: ' *',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: LightThemeColors.error,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: (value) {
              final trimmed = value?.trim() ?? '';
              switch (title.toLowerCase()) {
                case 'name':
                  return trimmed.isValidName
                      ? null
                      : 'Enter a valid name (letters and underscores)';
                case 'email':
                  return trimmed.isValidEmail ? null : 'Enter a valid email';
                case 'phone':
                  return trimmed.isValidPhoneNumber
                      ? null
                      : 'Enter a valid Egyptian phone number';
                case 'address':
                  return trimmed.isValidAddress
                      ? null
                      : 'Enter a valid address (5–100 chars)';
                case 'password':
                  return trimmed.isValidPassword
                      ? null
                      : 'Password must include upper, lower, number, special char and 8+ chars';
                default:
                  return trimmed.isEmpty ? 'This field is required' : null;
              }
            },
            decoration: InputDecoration(hintText: hintText),
          ),
        ],
      ),
    );
  }
}
