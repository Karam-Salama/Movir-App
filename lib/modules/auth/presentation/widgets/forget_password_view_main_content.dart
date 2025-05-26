import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/auth/presentation/cubits/reset_password_cubit.dart';

import '../../../../core/functions/validation.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubits/reset_password_state.dart';
import '../funcs/check_reset_password_state.dart';

class ForgetPasswordViewMainContent extends StatefulWidget {
  const ForgetPasswordViewMainContent({super.key});

  @override
  State<ForgetPasswordViewMainContent> createState() =>
      _ForgetPasswordViewMainContentState();
}

class _ForgetPasswordViewMainContentState
    extends State<ForgetPasswordViewMainContent> {
  @override
  Widget build(BuildContext context) {
    ResetPasswordCubit resetPasswordCubit =
        BlocProvider.of<ResetPasswordCubit>(context);

    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (BuildContext context, ResetPasswordState state) {
        checkResetPasswordStateEitherFailOrSuccess(state, context);
      },
      builder: (BuildContext context, ResetPasswordState state) {
        return Form(
          key: resetPasswordCubit.resetPasswordFormKey,
          autovalidateMode: resetPasswordCubit.resetPasswordAutoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                AppStrings.forgetPasswordTitle,
                style: AppTextStyle.Kanit500style32White,
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.forgetPasswordSubTitle,
                style: AppTextStyle.Kanit400style16White.copyWith(
                  color: AppColors.greyColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                hintText: AppStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email, color: AppColors.greyColor),
                onChanged: (email) {
                  resetPasswordCubit.email = email;
                },
                validator: Validation.validateEmail,
              ),
              const SizedBox(height: 30),
              state is ResetPasswordLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : CustomButton(
                      backGroundColor: AppColors.primaryColor,
                      text: AppStrings.forgetPasswordBtn,
                      onPressed: () async {
                        if (resetPasswordCubit
                            .resetPasswordFormKey.currentState!
                            .validate()) {
                          resetPasswordCubit.resetPasswordFormKey.currentState!
                              .save();
                          resetPasswordCubit
                              .resetPassword(resetPasswordCubit.email!);
                        } else {
                          setState(() {
                            resetPasswordCubit.resetPasswordAutoValidateMode =
                                AutovalidateMode.always;
                          });
                        }
                      },
                      style: AppTextStyle.Kanit500style18Black,
                      mainAxisAlignment: MainAxisAlignment.center,
                      padding: 0,
                    ),
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }
}
