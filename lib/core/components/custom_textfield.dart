import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
 CustomTextfield({super.key,required this.title, this.hintText,required this.controller, this.obscureText = false,required this.validator});

  String title;
  String? hintText;
  TextEditingController? controller;
  bool obscureText;
 final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}