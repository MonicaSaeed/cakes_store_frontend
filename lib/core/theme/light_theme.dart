import 'package:cakes_store_frontend/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 251, 248, 248),
  colorScheme: ColorScheme.fromSeed(
    seedColor: LightThemeColors.primary,
    primary: LightThemeColors.primary,
    secondary: LightThemeColors.secondary,
    background: LightThemeColors.background,
    surface: LightThemeColors.white,
    brightness: Brightness.light,
    tertiary: LightThemeColors.textLight,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: LightThemeColors.white,
    foregroundColor: LightThemeColors.primary,
    elevation: 3,
    titleTextStyle: TextStyle(
      color: LightThemeColors.primary,
      fontFamily: 'Pacifico',
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Pacifico',
      fontSize: 32,
      color: LightThemeColors.primary,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      color: LightThemeColors.textDark,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: LightThemeColors.textLight,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: LightThemeColors.textDark,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 12,
      color: LightThemeColors.primary,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.bold,
      decorationColor: LightThemeColors.secondary,
    ),
    labelSmall: TextStyle(
      color: LightThemeColors.textLight,
      fontSize: 12,
      fontStyle: FontStyle.italic,
      letterSpacing: 0.5,
    ),
    bodySmall: TextStyle(
      color: LightThemeColors.black,
      fontSize: 12,
      letterSpacing: 0.5,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightThemeColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: const Color.fromARGB(255, 218, 216, 216),
      ),
    ),
    hintStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: LightThemeColors.textLight,
    ),
  ),
  iconTheme: const IconThemeData(color: LightThemeColors.primary),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: LightThemeColors.primary,
    unselectedItemColor: LightThemeColors.textLight,
    selectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
    unselectedLabelStyle: TextStyle(fontFamily: 'Poppins'),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: LightThemeColors.primary,
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: LightThemeColors.primary,
      side: const BorderSide(color: LightThemeColors.primary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: LightThemeColors.secondary,
    selectedColor: LightThemeColors.primary,
    labelStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: LightThemeColors.white,
    ),
    secondaryLabelStyle: const TextStyle(
      fontFamily: 'Poppins',
      color: LightThemeColors.textDark,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFFDDDDDD),
    thickness: 1,
    space: 32,
  ),

  cardTheme: CardThemeData(
    color: LightThemeColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
);
