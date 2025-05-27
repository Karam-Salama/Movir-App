import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/movie_model.dart';
import '../../domain/search_repo.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  final SearchRepo searchRepo;

  SearchCubit({required this.searchRepo}) : super(SearchInitialState());

  TextEditingController searchController = TextEditingController();
  List<MovieModel> searchResults = [];

  Future<void> searchMovies({required String movieQuery}) async {
    emit(SearchLoadingState());
    final response = await searchRepo.searchMovies(movieQuery: movieQuery);

    response.fold(
      (failure) => emit(SearchFailureState(errorMessage: failure)),
      (movies) {
        searchResults = movies;
        emit(SearchSuccessState(movies: movies));
      },
    );
  }

  void clearSearch() {
    searchController.clear();
    searchResults = [];
    emit(SearchInitialState());
  }
}
