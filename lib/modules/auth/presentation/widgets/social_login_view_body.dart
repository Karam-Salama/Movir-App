import 'package:flutter/material.dart';
import 'package:movir_app/modules/auth/presentation/widgets/social_login_main_content.dart';

import '../../../../core/utils/app_assets.dart';

class SocialLoginViewBody extends StatelessWidget {
  const SocialLoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(Assets.assetsImagesLoginScreen),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SocialLoginMainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
