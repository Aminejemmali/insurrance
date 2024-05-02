import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Color
  static const Color primaryColor = Color(0xffCBB07F);
  static const Color secondaryColor = Color(0xff3A403B);

  // Regular colors
  static const Color darkGrey = Color(0xff303041);
  static const Color grey = Color(0xFF817B7B);
  static const Color offWhite = Color(0xFFF9F2E3);
  static const Color blue = Color(0xFF4285F4);
  static const Color hintTextGrey = Color(0xFF818181);
  static const Color lightGrey = Color(0xFFC9C9C9);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color burgundy = Color(0xFF880d1e);
  static const Color spaceCadet = Color(0xFFF4FCFE);
  static const Color green = Color(0xFF38FF06);
  static const Color red = Color(0xFFFF0606);
  static const Color orange = Color.fromARGB(255, 255, 114, 6);

  // Custom Dialog Colors
  static const Color customDialogSuccessColor = Color(0xff0FC6C2);
  static const Color customDialogErrorColor = Color(0xffED1E54);
  static const Color customDialogInfoColor = Color(0xffFFA200);
  static const Color customDialogQuestionColor = Color(0xff528AF7);

  // Gradients
  static const Gradient gradientOne = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.primaryColor,
      AppColors.secondaryColor,
    ],
  );

  static const Gradient gradientTwo = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.offWhite,
      AppColors.white,
    ],
  );

  static const Gradient gradientThree = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      AppColors.offWhite,
      AppColors.lightGrey,
    ],
  );
}
