import 'package:flutter/material.dart';
import 'package:furniture_app/core/constant/app_constant.dart';

class AppTheme {
  // 🎨 COLORS (ALL HERE)
  static const Color primaryColor = Color(0xFF15272B);
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFffffff);
  static const Color greyColor = Color(0xFFD9D9D9);
  static const Color greyLightColor = Color(0xFFDEE5E7);

  static const Color surface = Colors.white;


  static const Color border = Color(0xFFE5E5EA);
  static const Color error = Colors.red;

  // 🔤 TEXT THEME (WITH FONT)
  static final TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
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
    scaffoldBackgroundColor: whiteColor,

    primaryColor: primaryColor,

    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      error: error,
      surface: surface,
    ),

    textTheme: textTheme,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: surface,
      foregroundColor: blackColor,
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
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: error),
      ),
    ),
  );
}
