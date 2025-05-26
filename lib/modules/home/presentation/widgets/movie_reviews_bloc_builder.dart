import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'movie_reviews_list_view.dart';

class MovieReviewsBlocBuilder extends StatelessWidget {
  const MovieReviewsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is MovieReviewsLoadingState ||
          current is MovieReviewsSuccessState ||
          current is MovieReviewsFailureState,
      builder: (context, state) {
        if (state is MovieReviewsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MovieReviewsFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is MovieReviewsSuccessState) {
          return MovieReviewsListView(reviewList: state.reviews);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
