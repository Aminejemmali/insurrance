import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_text_style.dart';
import '../config/app_colors.dart';


class TextFormFieldWidget extends StatelessWidget {
  final String? hintText, initialText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;

  // final TextEditingController controller;
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    this.initialText,
    required this.controller,
    this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.hintTextStyle1,
      initialValue: initialText,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.hintTextStyle1,
        labelStyle: AppTextStyles.hintTextStyle1,
        contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        isDense: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 1, color: AppColors.customDialogErrorColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
