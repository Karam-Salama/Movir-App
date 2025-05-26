import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/service_locator.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubits/sign_in_cubit.dart';
import '../widgets/email_login_view_body.dart';

class EmailLoginView extends StatelessWidget {
  const EmailLoginView({super.key});
  static const routeName = '/email-login-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignInCubit(getIt<AuthRepo>()),
        child: const EmailLoginViewBody(),
      ),
    );
  }
}
