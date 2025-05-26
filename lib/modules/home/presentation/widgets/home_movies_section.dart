import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'movie_list_view.dart';
import 'shimmer_movies_list_view.dart';

class HomeMoviesSection extends StatelessWidget {
  const HomeMoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is MoviesListLoadingState ||
          current is MoviesListSuccessState ||
          current is MoviesListFailureState,
      builder: (context, state) {
        if (state is MoviesListLoadingState) {
          return const ShimmerMoviesListView();
        }

        if (state is MoviesListFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is MoviesListSuccessState) {
          return MovieListView(movies: state.movies);
        }

        return const ShimmerMoviesListView();
      },
    );
  }
}
