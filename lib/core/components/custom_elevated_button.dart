import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.textdata,
    required this.onPressed,
    this.color,
    this.width,
    required this.icon,
  });

  String textdata;
  VoidCallback onPressed;
  Color? color;
  int? width;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        icon: icon,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        label: Text(textdata, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
