import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../widgets/setting_view_body.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});
  static const routeName = '/Setting-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assetsImagesHomeBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SettingViewBody(),
      ),
    );
  }
}
