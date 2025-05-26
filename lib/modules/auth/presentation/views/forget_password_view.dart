import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/core/service/service_locator.dart';
import 'package:movir_app/modules/auth/presentation/widgets/forget_password_view_body.dart';

import '../../domain/repos/auth_repo.dart';
import '../cubits/reset_password_cubit.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  static const routeName = '/forget-password-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ResetPasswordCubit(getIt<AuthRepo>()),
        child: ForgetPasswordViewBody(),
      ),
    );
  }
}
