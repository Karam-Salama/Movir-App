import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import 'email_login_main_content.dart';

class EmailLoginViewBody extends StatelessWidget {
  const EmailLoginViewBody({super.key});

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
                child: EmailLoginMainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
