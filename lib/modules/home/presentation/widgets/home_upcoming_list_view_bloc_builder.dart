import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'home_upcoming_list_view.dart';
import 'shimmer_featured_list_view.dart';

class HomeUpcomingListViewBlocBuilder extends StatelessWidget {
  const HomeUpcomingListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is UpcomingMoviesLoadingState ||
          current is UpcomingMoviesSuccessState ||
          current is UpcomingMoviesFailureState,
      builder: (context, state) {
        if (state is UpcomingMoviesLoadingState) {
          return const ShimmerFeaturedListView();
        }

        if (state is UpcomingMoviesFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is UpcomingMoviesSuccessState) {
          return HomeUpcomingListView(movies: state.movies);
        }

        return const ShimmerFeaturedListView();
      },
    );
  }
}
