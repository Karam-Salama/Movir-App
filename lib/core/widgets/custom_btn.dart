// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.backGroundColor,
    this.borderColor,
    required this.text,
    required this.onPressed,
    required this.style,
    required this.mainAxisAlignment,
    this.padding,
    this.imageIcon,
  });

  final Color? backGroundColor;
  final Color? borderColor;
  final String? text;
  final VoidCallback? onPressed;
  final String? imageIcon;
  TextStyle? style;
  MainAxisAlignment mainAxisAlignment;
  double? padding;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 0),
      child: SizedBox(
        width: width ?? double.infinity,
        height: kHeightBottom,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backGroundColor ?? AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRaduisBorder),
              side: BorderSide(color: borderColor ?? Colors.transparent),
            ),
          ),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (imageIcon != null) ...[
                Image.asset(
                  imageIcon!,
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                const SizedBox(width: 12)
              ],
              Text(
                text!,
                style: style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
