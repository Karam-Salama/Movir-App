import 'package:flutter/material.dart';
import '../../../core/database/cache_helper.dart';
import '../../../core/functions/navigation.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/custom_btn.dart';
import '../../auth/presentation/views/social_login_view.dart';

class OnboardingMainContent extends StatelessWidget {
  const OnboardingMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          AppStrings.onboardingTitle,
          style: AppTextStyle.Kanit500style32White,
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.onboardingSubtitle,
          textAlign: TextAlign.center,
          style: AppTextStyle.Kanit400style16White,
        ),
        const SizedBox(height: 24),
        Image.asset(
          Assets.assetsImagesDots,
          width: 700,
          height: 10,
        ),
        const SizedBox(height: 24),
        CustomButton(
          backGroundColor: AppColors.primaryColor,
          text: AppStrings.onboardingGetStarted,
          onPressed: () {
            getIt<CacheHelper>().saveData(key: "welcomeVisited", value: true);
            customNavigate(context, SocialLoginView.routeName);
          },
          style: AppTextStyle.Kanit500style18Black,
          mainAxisAlignment: MainAxisAlignment.center,
          padding: 0,
        ),
      ],
    );
  }
}
