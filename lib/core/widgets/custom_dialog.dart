import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'custom_btn.dart';

class CustomDialog extends StatelessWidget {
  final IconData? icon;
  final String message;
  final String textButton;
  final VoidCallback? onpressed;

  const CustomDialog({
    super.key,
    required this.message,
    this.icon,
    required this.textButton,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyle.Kanit700style16Black,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          CustomButton(
            style: AppTextStyle.Kanit700style16Black.copyWith(
              color: AppColors.whiteColor,
            ),
            mainAxisAlignment: MainAxisAlignment.center,
            text: textButton,
            backGroundColor: AppColors.primaryColor,
            onPressed: onpressed!,
          ),
        ],
      ),
    );
  }
}
