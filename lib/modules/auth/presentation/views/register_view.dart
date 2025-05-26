import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/service_locator.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubits/sign_up_cubit.dart';
import '../widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const routeName = '/register-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpCubit(getIt<AuthRepo>()),
        child: const RegisterViewBody(),
      ),
    );
  }
}
