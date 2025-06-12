import 'package:flutter/material.dart';

import '../../../../core/functions/get_user.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SettingHeaderSection extends StatelessWidget {
  const SettingHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUser();
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              getUserPrefixLetter(user.name),
              style: AppTextStyle.Kanit400style16White,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: AppTextStyle.Kanit400style16White,
            ),
            Text(
              user.email,
              style: AppTextStyle.Kanit400style16White.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getUserPrefixLetter(String name) {
    // Handle empty or null name
    if (name.isEmpty) return "?";

    final parts = name.trim().split(' ');

    // If only one word, return first letter
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    // If multiple words, return first letters of first two words
    return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
  }
}
