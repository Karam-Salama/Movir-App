import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'home_popular_list_view.dart';
import 'shimmer_featured_list_view.dart';

class HomePopularListViewBlocBuilder extends StatelessWidget {
  const HomePopularListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is PopularMoviesLoadingState ||
          current is PopularMoviesSuccessState ||
          current is PopularMoviesFailureState,
      builder: (context, state) {
        if (state is PopularMoviesLoadingState) {
          return const ShimmerFeaturedListView();
        }

        if (state is PopularMoviesFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is PopularMoviesSuccessState) {
          return HomePopularListView(movies: state.movies);
        }

        return const ShimmerFeaturedListView();
      },
    );
  }
}
