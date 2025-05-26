import 'package:flutter/material.dart';
import 'package:movir_app/modules/auth/presentation/views/email_login_view.dart';

import '../../../../core/functions/build_custom_dialog.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../cubits/sign_up_state.dart';

void checkSignUpStateEitherFailOrSuccess(
    SignUpState state, BuildContext context) {
  if (state is SignUpSuccessState) {
    buildCustomDialog(
      context,
      CustomDialog(
        icon: Icons.check_circle,
        message: "verify your email to login",
        textButton: "Ok",
        onpressed: () {
          customReplacementNavigate(context, EmailLoginView.routeName);
        },
      ),
    );
  } else if (state is SignUpErrorState) {
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
