import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/setting/presentation/cubit/sign_out_cubit.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../core/service/service_locator.dart';
import '../../../auth/domain/repos/auth_repo.dart';
import '../widgets/setting_view_body.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});
  static const routeName = '/Setting-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assetsImagesHomeBg),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider(
          create: (context) => SignOutCubit(authRepo: getIt<AuthRepo>()),
          child: SettingViewBody(),
        ),
      ),
    );
  }
}
