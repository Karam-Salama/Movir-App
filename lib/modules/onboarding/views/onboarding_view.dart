import 'package:flutter/material.dart';

import '../widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  static const routeName = '/onboarding-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingViewBody(),
    );
  }
}
