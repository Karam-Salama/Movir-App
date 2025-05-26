import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/auth/presentation/views/forget_password_view.dart';

import '../../../../core/functions/navigation.dart';
import '../../../../core/functions/validation.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubits/sign_in_cubit.dart';
import '../cubits/sign_in_state.dart';
import '../cubits/social_cubit.dart';
import '../funcs/check_sign_In_state.dart';
import '../views/register_view.dart';
import 'custom_social_login.dart';
import 'have_an_account_widget.dart';

class EmailLoginMainContent extends StatefulWidget {
  const EmailLoginMainContent({super.key});

  @override
  State<EmailLoginMainContent> createState() => _EmailLoginMainContentState();
}

class _EmailLoginMainContentState extends State<EmailLoginMainContent> {
  @override
  Widget build(BuildContext context) {
    SignInCubit signInCubit = BlocProvider.of<SignInCubit>(context);
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        checkSignInStateEitherFailOrSuccess(state, context);
      },
      builder: (context, state) {
        return Form(
          key: signInCubit.signInFormKey,
          autovalidateMode: signInCubit.SignInAutoValidateMode,
          child: Column(
            children: [
              Text(
                AppStrings.emailLoginTitle,
                style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: AppStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email, color: AppColors.greyColor),
                onChanged: (email) {
                  signInCubit.email = email;
                },
                validator: Validation.validateEmail,
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                hintText: AppStrings.passwordHint,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !signInCubit.isPasswordVisible,
                prefixIcon: Icon(Icons.lock, color: AppColors.greyColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    signInCubit.isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.greyColor,
                  ),
                  onPressed: () {
                    signInCubit.togglePasswordVisibility();
                  },
                ),
                validator: Validation.validatePassword,
                onSaved: (password) {
                  signInCubit.password = password;
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    customNavigate(context, ForgetPasswordView.routeName);
                  },
                  child: Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyle.Kanit400style14primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              state is SignInLoadingState
                  ? CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      backGroundColor: AppColors.primaryColor,
                      text: AppStrings.signIn,
                      onPressed: () async {
                        if (signInCubit.signInFormKey.currentState!
                            .validate()) {
                          signInCubit.signInFormKey.currentState!.save();
                          signInCubit.signInWithEmailAndPassword(
                            signInCubit.email!,
                            signInCubit.password!,
                          );
                        } else {
                          setState(() {
                            signInCubit.SignInAutoValidateMode =
                                AutovalidateMode.always;
                          });
                        }
                      },
                      style: AppTextStyle.Kanit500style18Black,
                      mainAxisAlignment: MainAxisAlignment.center,
                      padding: 0,
                    ),
              const SizedBox(height: 10),
              Image.asset(Assets.assetsImagesOrContinueWith),
              const SizedBox(height: 10),
              BlocProvider(
                create: (context) => SignInSocialCubit(getIt<AuthRepo>()),
                child: const CustomSocialLogin(),
              ),
              HaveAccountWidget(
                textPart1: AppStrings.dontHaveAccount,
                textPart2: AppStrings.register,
                onPress: () {
                  customNavigate(context, RegisterView.routeName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
