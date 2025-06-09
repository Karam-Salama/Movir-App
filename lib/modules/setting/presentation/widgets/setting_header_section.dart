import 'package:flutter/material.dart';

import '../../../../core/functions/get_user.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SettingHeaderSection extends StatelessWidget {
  const SettingHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              getUserPrefixLetter(),
              style: AppTextStyle.Kanit400style16White,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getUser().name,
              style: AppTextStyle.Kanit400style16White,
            ),
            Text(
              getUser().email,
              style: AppTextStyle.Kanit400style16White.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  getUserPrefixLetter() {
    return getUser().name.split(' ')[0][0].toLowerCase() +
        getUser().name.split(' ')[1][0].toLowerCase();
  }
}
