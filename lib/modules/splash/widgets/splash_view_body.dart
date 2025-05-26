import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/database/cache_helper.dart';
import '../../../core/functions/navigation.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utils/app_assets.dart';
import '../../auth/presentation/views/email_login_view.dart';
import '../../bottom_nav_bar.dart';
import '../../onboarding/views/onboarding_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    bool welcomeVisited =
        getIt<CacheHelper>().getData(key: "welcomeVisited") ?? false;
    if (welcomeVisited == true) {
      FirebaseAuth.instance.currentUser == null
          ? delayedNavigate(EmailLoginView.routeName)
          : FirebaseAuth.instance.currentUser!.emailVerified == true
              ? delayedNavigate(BottomNavBar.routeName)
              : delayedNavigate(EmailLoginView.routeName);
    } else {
      delayedNavigate(OnboardingView.routeName);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assetsImagesSplashScreen),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void delayedNavigate(String routeName) {
    Future.delayed(const Duration(seconds: 2), () {
      customReplacementNavigate(context, routeName);
    });
  }
}
