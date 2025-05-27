import 'package:flutter/material.dart';
import 'package:movir_app/modules/home/data/models/movie_model.dart';

@immutable
sealed class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final List<MovieModel> movies;

  SearchSuccessState({required this.movies});
}

class SearchFailureState extends SearchStates {
  final String errorMessage;

  SearchFailureState({required this.errorMessage});
}
