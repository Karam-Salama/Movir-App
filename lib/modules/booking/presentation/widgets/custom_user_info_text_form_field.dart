import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomUserInfoTextFormField extends StatelessWidget {
  const CustomUserInfoTextFormField({
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
  final String hintText;
  final bool? obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
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
        enabledBorder: getBorderUserInfoStyle(),
        focusedBorder: getBorderUserInfoStyle(),
        border: getBorderUserInfoStyle(),
        hintText: hintText,
        hintStyle: AppTextStyle.Kanit400style16White.copyWith(
            fontSize: 14, color: AppColors.greyColor),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }

  OutlineInputBorder getBorderUserInfoStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.lightGrey2,
        width: 1.0,
      ),
    );
  }
}
