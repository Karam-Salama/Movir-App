import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/service_locator.dart';
import '../../domain/repos/auth_repo.dart';
import '../cubits/social_cubit.dart';
import '../widgets/social_login_view_body.dart';

class SocialLoginView extends StatelessWidget {
  const SocialLoginView({super.key});
  static const routeName = '/social-login-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => SignInSocialCubit(getIt<AuthRepo>()),
          child: const SocialLoginViewBody()),
    );
  }
}
