import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/functions/build_custom_dialog.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../bottom_nav_bar.dart';
import '../cubits/sign_in_state.dart';
import '../cubits/social_state.dart';

void checkSignInSocialStateEitherFailOrSuccess(
    SignInSocialState state, BuildContext context) {
  if (state is SignInSocialSuccessState) {
    buildCustomDialog(
      context,
      CustomDialog(
        icon: Icons.check_circle,
        message: "Login successfully",
        textButton: "Ok",
        onpressed: () {
          customReplacementNavigate(context, BottomNavBar.routeName);
        },
      ),
    );
  } else if (state is SignInSocialErrorState) {
    buildCustomDialog(
      context,
      CustomDialog(
        icon: Icons.error,
        message: state.errorMessage,
        textButton: "try again",
        onpressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

void checkSignInStateEitherFailOrSuccess(
    SignInState state, BuildContext context) {
  if (state is SignInSuccessState) {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      buildCustomDialog(
        context,
        CustomDialog(
          icon: Icons.check_circle,
          message: "Login successfully",
          textButton: "Ok",
          onpressed: () {
            customReplacementNavigate(context, BottomNavBar.routeName);
          },
        ),
      );
    } else {
      buildCustomDialog(
        context,
        CustomDialog(
          icon: Icons.error,
          message: "Please verify your email",
          textButton: "Ok",
          onpressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  } else if (state is SignInErrorState) {
    buildCustomDialog(
      context,
      CustomDialog(
        icon: Icons.error,
        message: state.errorMessage,
        textButton: "try again",
        onpressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
