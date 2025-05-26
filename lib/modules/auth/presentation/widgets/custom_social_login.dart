import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubits/social_cubit.dart';
import '../cubits/social_state.dart';
import '../funcs/check_sign_In_state.dart';
import 'custom_social_container.dart';

class CustomSocialLogin extends StatelessWidget {
  const CustomSocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInSocialCubit, SignInSocialState>(
        listener: (context, state) {
      checkSignInSocialStateEitherFailOrSuccess(state, context);
    }, builder: (context, state) {
      SignInSocialCubit signInSocialCubit =
          BlocProvider.of<SignInSocialCubit>(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state is SignInfacebookLoadingState
              ? const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
              : CustomSocialContainer(
                  image: Assets.assetsImagesFacebookLogo,
                  onTap: () {
                    signInSocialCubit.signInWithFacebook();
                  },
                ),
          const SizedBox(width: 12),
          state is SignInGoogleLoadingState
              ? const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
              : CustomSocialContainer(
                  image: Assets.assetsImagesGoogleLogo,
                  onTap: () {
                    signInSocialCubit.signInWithGoogle();
                  },
                ),
          const SizedBox(width: 12),
          Theme.of(context).platform == TargetPlatform.iOS
              ? state is SignInAppleLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomSocialContainer(
                      image: Assets.assetsImagesAppleLogo,
                      onTap: () {
                        signInSocialCubit.signInWithApple();
                      },
                    )
              : SizedBox.shrink(),
        ],
      );
    });
  }
}
