import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'home_trending_list_view.dart';
import 'shimmer_featured_list_view.dart';

class HomeTrendingListViewBlocBuilder extends StatelessWidget {
  const HomeTrendingListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is TrendingMoviesLoadingState ||
          current is TrendingMoviesSuccessState ||
          current is TrendingMoviesFailureState,
      builder: (context, state) {
        if (state is TrendingMoviesLoadingState) {
          return const ShimmerFeaturedListView();
        }

        if (state is TrendingMoviesFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is TrendingMoviesSuccessState) {
          return HomeTrendingListView(movies: state.movies);
        }

        return const ShimmerFeaturedListView();
      },
    );
  }
}
