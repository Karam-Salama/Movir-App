import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'home_now_playing_list_view.dart';
import 'shimmer_featured_list_view.dart';

class HomeNowPlayingListViewBlocBuilder extends StatelessWidget {
  const HomeNowPlayingListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is NowPlayingMoviesLoadingState ||
          current is NowPlayingMoviesSuccessState ||
          current is NowPlayingMoviesFailureState,
      builder: (context, state) {
        if (state is NowPlayingMoviesLoadingState) {
          return const ShimmerFeaturedListView();
        }

        if (state is NowPlayingMoviesFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is NowPlayingMoviesSuccessState) {
          return HomeNowPlayingListView(movies: state.movies);
        }

        return const ShimmerFeaturedListView();
      },
    );
  }
}
