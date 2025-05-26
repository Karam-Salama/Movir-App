import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'custom_color_container.dart';

class SeatStatusWidget extends StatelessWidget {
  const SeatStatusWidget({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomColorContainer(color: color),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyle.Kanit400style16White.copyWith(
            fontSize: 12,
            color: AppColors.lightGrey2,
          ),
        ),
      ],
    );
  }
}
