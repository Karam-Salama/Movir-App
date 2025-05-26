import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/core/utils/app_assets.dart';
import '../../../../core/service/service_locator.dart';
import '../../domain/repos/home_repo.dart';
import '../cubit/home_cubit.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = '/home-view';

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
          create: (context) => HomeCubit(homeRepo: getIt<HomeRepo>())
            ..getCategoriesData()
            ..getMoviesListByCategoryId(categoryId: '28')
            ..getTopRatedMovies()
            ..getPopularMovies()
            ..getUpcomingMovies()
            ..getNowPlayingMovies()
            ..getTrendingMovies(),
          child: const HomeViewBody(),
        ),
      ),
    );
  }
}
