import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';

class CustomSammaryMiddleRow extends StatelessWidget {
  const CustomSammaryMiddleRow({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1, text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: AppTextStyle.Kanit400style12Grey.copyWith(fontSize: 16),
        ),
        Text(text2),
      ],
    );
  }
}
