import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/search_cubit.dart';
import '../cubit/search_states.dart';
import 'movie_card.dart';
import 'no_results_found_view.dart';

class FilteredMoviesListviewBlocBuilder extends StatelessWidget {
  const FilteredMoviesListviewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        final searchCubit = BlocProvider.of<SearchCubit>(context);

        if (state is SearchLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchSuccessState &&
            searchCubit.searchResults.isNotEmpty) {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchCubit.searchResults.length,
            itemBuilder: (context, index) {
              final movies = searchCubit.searchResults;
              final movieModel = movies[index];
              return MovieCard(movieModel: movieModel);
            },
          );
        }

        if (state is SearchSuccessState && searchCubit.searchResults.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const NoResultsFoundView(),
          );
        }

        return const SizedBox();
      },
    );
  }
}
