import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomRowSettingItem extends StatelessWidget {
  const CustomRowSettingItem({
    super.key,
    required this.onTap,
    this.icon,
    required this.data,
    this.leading,
  });
  final void Function() onTap;
  final String data;
  final IconData? icon;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assetsImagesReviewCard),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: leading ??
              Icon(
                icon,
                color: AppColors.primaryColor,
              ),
          title: Text(
            data,
            style: AppTextStyle.Kanit400style16White,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
