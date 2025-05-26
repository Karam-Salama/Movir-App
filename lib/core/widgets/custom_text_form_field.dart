import 'package:flutter/material.dart';
import 'package:movir_app/core/utils/app_colors.dart';

import '../utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      style: AppTextStyle.Kanit600style14White.copyWith(fontSize: 16),
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: getBorderStyle(),
        focusedBorder: getBorderStyle(),
        border: getBorderStyle(),
        hintText: hintText,
        hintStyle: AppTextStyle.Kanit400style16White.copyWith(
            fontSize: 14, color: AppColors.greyColor),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: AppColors.darkColor,
      ),
    );
  }
}

OutlineInputBorder getBorderStyle() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: AppColors.darkColor,
      width: 1.0,
    ),
  );
}
