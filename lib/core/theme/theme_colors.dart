import 'package:flutter/material.dart';

class LightThemeColors {
  static const Color primary = Color(0xFF432c23); // Logo pink
  // static const Color primary = Color(0xFF245383); // Logo pink
  static const Color secondary = Color.fromARGB(
    255,
    255,
    213,
    213,
  ); // Light soft pink
  static const Color background = Color(0xFFFAFAFA); // Light background
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFF888888);
  static const Color white = Colors.white;
  static const Color backgroundGrey = Color(0xFFf3f4f6);
  static const Color black = Colors.black;
  static const Color error = Color(0xFFFF5252);
  static const Color iconColor = Color(0xfffff9c4);
}

class DarkThemeColors {
  static const Color primary = Color.fromARGB(
    255,
    238,
    102,
    138,
  ); // Same as logo pink
  static const Color secondary = Color(0xFFFF6F91); // Slightly deeper pink
  static const Color background = Color(0xFF121212); // Typical dark background
  static const Color surface = Color(0xFF1E1E1E); // Card/app bar surface
  static const Color textDark = Colors.white; // Inverted
  static const Color textLight = Color(0xFFBBBBBB); // Softer white
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color iconColor = Color(0xfffff9c4);
}
