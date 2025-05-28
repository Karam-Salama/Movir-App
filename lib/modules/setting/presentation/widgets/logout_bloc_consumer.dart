import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/functions/build_custom_dialog.dart';
import '../../../../core/functions/build_logout_dialog.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../auth/presentation/views/email_login_view.dart';
import '../cubit/sign_out_cubit.dart';
import '../cubit/sign_out_state.dart';

class LogoutBlocConsumer extends StatelessWidget {
  const LogoutBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    SignOutCubit signOutCubit = BlocProvider.of<SignOutCubit>(context);
    return BlocConsumer<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const EmailLoginView(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        } else if (state is SignOutErrorState) {
          buildCustomDialog(
            context,
            CustomDialog(
              icon: Icons.error,
              message: state.message,
              textButton: "ok",
              onpressed: () => Navigator.pop(context),
            ),
          );
        }
      },
      builder: (context, state) {
        return state is SignOutLoadingState
            ? const CircularProgressIndicator(
                color: AppColors.primaryColor,
              )
            : CustomButton(
                text: AppStrings.logout,
                onPressed: () {
                  buildLogoutDialog(context, signOutCubit);
                },
                style: AppTextStyle.Kanit400style16White,
                mainAxisAlignment: MainAxisAlignment.center,
                imageIcon: Assets.assetsImagesLogoutImage,
                backGroundColor: AppColors.primaryColor,
              );
      },
    );
  }
}
