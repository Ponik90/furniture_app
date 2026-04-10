import 'package:flutter/material.dart';
import 'package:furniture_app/core/constant/app_constant.dart';

class AppTheme {
  // 🎨 COLORS (ALL HERE)
  static const Color primary = Color(0xFF3E64FF);
  static const Color secondary = Color(0xFFFFA500);

  static const Color background = Color(0xFFF8F9FB);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF6E6E73);

  static const Color border = Color(0xFFE5E5EA);
  static const Color error = Colors.red;

  // 🔤 TEXT THEME (WITH FONT)
  static final TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: AppConstant.fontFamily,
      color: textPrimary,
    ),

    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: textPrimary,
    ),

    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: textPrimary,
    ),

    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: textPrimary,
    ),

    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: textSecondary,
    ),

    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: textSecondary,
    ),

    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstant.fontFamily,
      color: Colors.white,
    ),
  );

  // 🌙 MAIN THEME
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: background,

    primaryColor: primary,

    colorScheme: const ColorScheme.light().copyWith(
      primary: primary,
      secondary: secondary,
      error: error,
      surface: surface,
    ),

    textTheme: textTheme,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: surface,
      foregroundColor: textPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: error),
      ),
    ),
  );
}