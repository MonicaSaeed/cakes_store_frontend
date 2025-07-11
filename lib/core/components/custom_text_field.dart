import 'package:cakes_store_frontend/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.hintText,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
  });

  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
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
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: Theme.of(context).textTheme.labelSmall,
            maxLines: maxLines,
            validator: (value) {
              final trimmed = value?.trim() ?? '';
              final cleanTitle = title.replaceAll('*', '').trim().toLowerCase();

              switch (cleanTitle) {
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
                      : 'Password must include 8+ chars';
                default:
                  return trimmed.isEmpty ? 'This field is required' : null;
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
