import 'package:flutter/material.dart';
import '../../../core/utils/app_assets.dart';
import 'onboarding_main_content.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(Assets.assetsImagesWelcomeScreen),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OnboardingMainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
