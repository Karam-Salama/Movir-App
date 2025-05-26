import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/auth/presentation/cubits/sign_up_cubit.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/functions/validation.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubits/sign_up_state.dart';
import '../funcs/check_signUp_state.dart';
import '../views/email_login_view.dart';
import 'have_an_account_widget.dart';

class RegisterViewMainContent extends StatefulWidget {
  const RegisterViewMainContent({super.key});

  @override
  State<RegisterViewMainContent> createState() =>
      _RegisterViewMainContentState();
}

class _RegisterViewMainContentState extends State<RegisterViewMainContent> {
  @override
  Widget build(BuildContext context) {
    SignUpCubit signUpCubit = BlocProvider.of<SignUpCubit>(context);
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        checkSignUpStateEitherFailOrSuccess(state, context);
      },
      builder: (context, state) {
        return Form(
          key: signUpCubit.signUpFormKey,
          autovalidateMode: signUpCubit.SignUpAutoValidateMode,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                AppStrings.registerNewAccount,
                style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: AppStrings.nameHint,
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.person, color: AppColors.greyColor),
                onChanged: (name) {
                  signUpCubit.name = name;
                },
                validator: Validation.validateName,
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: AppStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email, color: AppColors.greyColor),
                onChanged: (email) {
                  signUpCubit.emailAddress = email;
                },
                validator: Validation.validateEmail,
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: AppStrings.passwordHint,
                obscureText: !signUpCubit.isPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(Icons.lock, color: AppColors.greyColor),
                validator: Validation.validatePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    signUpCubit.isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.greyColor,
                  ),
                  onPressed: () {
                    signUpCubit.togglePasswordVisibility();
                  },
                ),
                onSaved: (password) {
                  signUpCubit.password = password;
                },
              ),
              const SizedBox(height: 50),
              state is SignUpLoadingState
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor)
                  : CustomButton(
                      backGroundColor: AppColors.primaryColor,
                      text: AppStrings.register,
                      onPressed: () {
                        if (signUpCubit.signUpFormKey.currentState!
                            .validate()) {
                          signUpCubit.signUpFormKey.currentState!.save();
                          context
                              .read<SignUpCubit>()
                              .createUserWithEmailAndPassword(
                                signUpCubit.emailAddress!,
                                signUpCubit.password!,
                                signUpCubit.name!,
                              );
                        } else {
                          setState(() {
                            signUpCubit.SignUpAutoValidateMode =
                                AutovalidateMode.always;
                          });
                        }
                      },
                      style: AppTextStyle.Kanit500style18Black,
                      mainAxisAlignment: MainAxisAlignment.center,
                      padding: 0,
                    ),
              HaveAccountWidget(
                textPart1: AppStrings.alreadyHaveAccount,
                textPart2: AppStrings.login,
                onPress: () {
                  customNavigate(context, EmailLoginView.routeName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
