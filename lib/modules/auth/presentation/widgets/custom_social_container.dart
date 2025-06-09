import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomSocialContainer extends StatelessWidget {
  const CustomSocialContainer({
    super.key,
    required this.image,
    required this.onTap,
  });
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.darkColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Image.asset(image),
          ),
        ),
      ),
    );
  }
}
