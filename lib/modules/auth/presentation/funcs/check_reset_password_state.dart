import 'package:flutter/material.dart';
import 'package:movir_app/modules/auth/presentation/views/email_login_view.dart';

import '../../../../core/functions/build_custom_dialog.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../cubits/reset_password_state.dart';

void checkResetPasswordStateEitherFailOrSuccess(
    ResetPasswordState state, BuildContext context) {
  if (state is ResetPasswordSuccessState) {
    buildCustomDialog(
      context,
      CustomDialog(
        icon: Icons.check_circle,
        message: "check your email to change your password",
        textButton: "Ok",
        onpressed: () {
          customReplacementNavigate(context, EmailLoginView.routeName);
        },
      ),
    );
  } else if (state is ResetPasswordErrorState)
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
