import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:movir_app/modules/search/domain/search_repo.dart';

import '../../../../core/service/service_locator.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../home/domain/repos/home_repo.dart';
import '../cubit/search_cubit.dart';
import '../widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const routeName = '/search-view';
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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    SearchCubit(searchRepo: getIt<SearchRepo>())),
            BlocProvider(
                create: (context) => HomeCubit(homeRepo: getIt<HomeRepo>())),
          ],
          child: SearchViewBody(),
        ),
      ),
    );
  }
}
