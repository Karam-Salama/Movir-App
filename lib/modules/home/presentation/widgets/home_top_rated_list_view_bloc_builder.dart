import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'home_top_rated_list_view.dart';
import 'shimmer_featured_list_view.dart';

class HomeTopRatedListViewBlocBuilder extends StatelessWidget {
  const HomeTopRatedListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is TopRatedMoviesLoadingState ||
          current is TopRatedMoviesSuccessState ||
          current is TopRatedMoviesFailureState,
      builder: (context, state) {
        if (state is TopRatedMoviesLoadingState) {
          return const ShimmerFeaturedListView();
        }

        if (state is TopRatedMoviesFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is TopRatedMoviesSuccessState) {
          return HomeTopRatedListView(movies: state.movies);
        }

        return const ShimmerFeaturedListView();
      },
    );
  }
}
