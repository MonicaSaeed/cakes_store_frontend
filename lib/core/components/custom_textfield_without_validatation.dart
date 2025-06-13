import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWithoutValidation extends StatelessWidget {
  const CustomTextFieldWithoutValidation({
    super.key,
    required this.title,
    this.hintText,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

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
            style: Theme.of(context).textTheme.bodySmall,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintStyle: Theme.of(context).textTheme.labelSmall,
            ),
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
