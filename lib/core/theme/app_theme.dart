import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // 🔥 DISPLAY
    displayLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    displayMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    displaySmall: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    // 🔥 HEADLINE
    headlineLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    // 🔥 TITLE
    titleLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    // 🔥 BODY
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),

    // 🔥 LABEL
    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.fontFamily,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
    ),
    labelSmall: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstant.fontFamily,
      color: blackColor,
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
  );
}
