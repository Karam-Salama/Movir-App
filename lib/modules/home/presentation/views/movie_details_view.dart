import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/home/data/models/movie_model.dart';
import 'package:movir_app/modules/home/presentation/cubit/home_states.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utils/app_assets.dart';
import '../../domain/repos/home_repo.dart';
import '../cubit/home_cubit.dart';
import '../widgets/movie_details_view_body.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key, required this.movieModel});
  static const String routeName = '/movieDetailsView';
  final MovieModel movieModel;
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
              ..getMovieDetailsById(movieId: movieModel.id.toString())
              ..getMovieCrew(movieId: movieModel.id.toString())
              ..getMovieReviews(movieId: movieModel.id.toString()),
            child: MovieDetailsBlocBuilder(movieModel: movieModel)),
      ),
    );
  }
}

class MovieDetailsBlocBuilder extends StatelessWidget {
  const MovieDetailsBlocBuilder({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is MovieDetailsLoadingState ||
          current is MovieDetailsSuccessState ||
          current is MovieDetailsFailureState,
      builder: (context, state) {
        if (state is MovieDetailsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MovieDetailsFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is MovieDetailsSuccessState) {
          return MovieDetailsViewBody(
              movieDetailsModel: state.movieDetailsModel);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
