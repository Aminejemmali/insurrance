import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color lightGrey = Color(0xFFBDBDBD);
}

class AppTextStyles {
  static const TextStyle bodyTextStyle8 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle bodyTextStyle1 = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  static const TextStyle buttonTextStyle1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle buttonTextStyle3 = TextStyle(
    fontSize: 14,
    color: Colors.blue,
  );
  static const TextStyle underlineTextStyle1 = TextStyle(
    fontSize: 16,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
}

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.offWhite,
    textTheme: TextTheme(
      bodyText1: AppTextStyles.bodyTextStyle1,
      bodyText2: AppTextStyles.bodyTextStyle8,
      button: AppTextStyles.buttonTextStyle1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
