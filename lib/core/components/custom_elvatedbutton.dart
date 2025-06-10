import 'package:flutter/material.dart';

class CustomElevatedbutton extends StatelessWidget {
   CustomElevatedbutton({super.key,required this.textdata,required this.onPressed, this.color, this.width, required this.icon});

  String textdata;
  VoidCallback onPressed;
  Color? color;
  int? width;
 Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: icon,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: onPressed, 
          label: Text(
             textdata,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,  
          ),
        ),
        ),
      ],
    );
  }
}