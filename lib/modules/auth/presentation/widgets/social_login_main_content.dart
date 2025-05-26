import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../cubits/social_cubit.dart';
import '../cubits/social_state.dart';
import '../funcs/check_sign_In_state.dart';
import '../views/email_login_view.dart';
import '../views/register_view.dart';
import 'have_an_account_widget.dart';

class SocialLoginMainContent extends StatelessWidget {
  const SocialLoginMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInSocialCubit, SignInSocialState>(
        listener: (context, state) {
      checkSignInSocialStateEitherFailOrSuccess(state, context);
    }, builder: (context, state) {
      SignInSocialCubit signInSocialCubit =
          BlocProvider.of<SignInSocialCubit>(context);
      return Column(
        children: [
          const SizedBox(height: 20),
          Text(
            AppStrings.socialLoginTitle,
            style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),
          state is SignInfacebookLoadingState
              ? const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
              : CustomButton(
                  text: AppStrings.loginFacebook,
                  onPressed: () {
                    signInSocialCubit.signInWithFacebook();
                  },
                  style: AppTextStyle.Kanit400style16White,
                  imageIcon: Assets.assetsImagesFacebookLogo,
                  backGroundColor: AppColors.darkColor,
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: 0,
                ),
          const SizedBox(height: 12),
          state is SignInGoogleLoadingState
              ? const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
              : CustomButton(
                  text: AppStrings.loginGoogle,
                  onPressed: () {
                    signInSocialCubit.signInWithGoogle();
                  },
                  style: AppTextStyle.Kanit400style16White,
                  imageIcon: Assets.assetsImagesGoogleLogo,
                  backGroundColor: AppColors.darkColor,
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: 0,
                ),
          const SizedBox(height: 12),
          Theme.of(context).platform == TargetPlatform.iOS
              ? state is SignInAppleLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      text: AppStrings.loginApple,
                      onPressed: () {
                        signInSocialCubit.signInWithApple();
                      },
                      style: AppTextStyle.Kanit400style16White,
                      imageIcon: Assets.assetsImagesAppleLogo,
                      backGroundColor: AppColors.darkColor,
                      mainAxisAlignment: MainAxisAlignment.center,
                      padding: 0,
                    )
              : const SizedBox.shrink(),
          const SizedBox(height: 24),
          Image.asset(Assets.assetsImagesOr),
          const SizedBox(height: 24),
          CustomButton(
            text: AppStrings.loginPassword,
            onPressed: () {
              customNavigate(context, EmailLoginView.routeName);
            },
            style: AppTextStyle.Kanit500style18Black,
            mainAxisAlignment: MainAxisAlignment.center,
            padding: 0,
          ),
          HaveAccountWidget(
            textPart1: AppStrings.dontHaveAccount,
            textPart2: AppStrings.register,
            onPress: () {
              customNavigate(context, RegisterView.routeName);
            },
          ),
        ],
      );
    });
  }
}
