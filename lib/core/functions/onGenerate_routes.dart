// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:movir_app/modules/home/presentation/views/home_view.dart';
import '../../modules/auth/presentation/views/email_login_view.dart';
import '../../modules/auth/presentation/views/forget_password_view.dart';
import '../../modules/auth/presentation/views/register_view.dart';
import '../../modules/auth/presentation/views/social_login_view.dart';
import '../../modules/bottom_nav_bar.dart';
import '../../modules/onboarding/views/onboarding_view.dart';
import '../../modules/splash/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnboardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnboardingView());
    case SocialLoginView.routeName:
      return MaterialPageRoute(builder: (context) => const SocialLoginView());
    case EmailLoginView.routeName:
      return MaterialPageRoute(builder: (context) => const EmailLoginView());
    case RegisterView.routeName:
      return MaterialPageRoute(builder: (context) => const RegisterView());
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordView());
    case BottomNavBar.routeName:
      return MaterialPageRoute(builder: (context) => const BottomNavBar());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
