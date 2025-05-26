import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import 'forget_password_view_main_content.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(Assets.assetsImagesLoginScreen),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ForgetPasswordViewMainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
