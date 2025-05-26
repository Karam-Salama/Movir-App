import 'package:flutter/material.dart';
import '../../../../core/functions/get_user.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        AppStrings.welcome + ' ${getUser().name}',
        style: AppTextStyle.Kanit500style16LighterGrey,
      ),
      subtitle: Text(
        AppStrings.homeSubtitle,
        style: AppTextStyle.Kanit400style12Grey,
      ),
      trailing: Image.asset(
        Assets.assetsImagesUserAvatar,
        width: 40,
        height: 40,
      ),
    );
  }
}
