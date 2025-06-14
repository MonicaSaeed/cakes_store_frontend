import 'package:flutter/material.dart';

class CustomPasswordTextfield extends StatefulWidget {
  const CustomPasswordTextfield({
    super.key,
    required this.title,
    this.hintText,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
  });

  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  @override
  State<CustomPasswordTextfield> createState() =>
      _CustomPasswordTextfieldState();
}

class _CustomPasswordTextfieldState extends State<CustomPasswordTextfield> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.title.replaceAll('*', ''),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                if (widget.title.contains('*'))
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
          // TextFormField
          TextFormField(
            controller: widget.controller,
            obscureText: !_isPasswordVisible,
            style: Theme.of(context).textTheme.labelSmall,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 22,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
