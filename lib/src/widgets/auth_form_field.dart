import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_text_style.dart';

import '../config/app_colors.dart';

class AuthTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final Color prefixIconColor;
  final String? prefixIcon, errorText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;

  // final TextEditingController controller;
  AuthTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIconColor,
    required this.prefixIcon,
    required this.controller,
    this.onChanged,
    required this.validator,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: AppTextStyles.hintTextStyle1,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          hintStyle: AppTextStyles.hintTextStyle1,
          labelStyle: AppTextStyles.hintTextStyle1,
          errorStyle: AppTextStyles.bodyTextStyle1,
          contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          isDense: true,
          prefixIcon: Container(
            padding: const EdgeInsets.all(10),
            height: 20,
            child: FittedBox(
              fit: BoxFit.cover,
              child: ImageIcon(
                AssetImage(prefixIcon!),
                color: prefixIconColor,
                size: 20,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: AppColors.customDialogErrorColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator);
  }
}

class AuthPasswordFormFieldWidget extends StatelessWidget {
  final String hintText;
  final Color prefixIconColor;
  final String? prefixIcon, errorText;
  final Widget? suffixIcon;
  final bool? obsecureText;
  final TextEditingController controller;
  final VoidCallback suffixIconOnTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;

  // final TextEditingController controller;
  AuthPasswordFormFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIconColor,
    required this.prefixIcon,
    required this.controller,
    this.onChanged,
    required this.validator,
    this.suffixIcon,
    required this.suffixIconOnTap,
    this.obsecureText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: AppTextStyles.hintTextStyle1,
        controller: controller,
        onChanged: onChanged,
        obscureText: obsecureText!,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          hintStyle: AppTextStyles.hintTextStyle1,
          labelStyle: AppTextStyles.hintTextStyle1,
          errorStyle: AppTextStyles.bodyTextStyle1,
          contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          isDense: true,
          prefixIcon: Container(
            padding: const EdgeInsets.all(10),
            height: 20,
            child: FittedBox(
              fit: BoxFit.cover,
              child: ImageIcon(
                AssetImage(prefixIcon!),
                color: prefixIconColor,
                size: 20,
              ),
            ),
          ),
          suffixIcon: InkWell(onTap: suffixIconOnTap, child: suffixIcon),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: AppColors.customDialogErrorColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator);
  }
}
