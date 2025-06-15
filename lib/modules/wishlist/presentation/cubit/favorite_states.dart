import 'package:flutter/material.dart';
import 'package:movir_app/modules/home/data/models/movie_model.dart';

@immutable
sealed class FavoriteStates {}

class FavoritesInitialState extends FavoriteStates {}

class FavoritesLoadingState extends FavoriteStates {}

class FavoritesSuccessState extends FavoriteStates {}

class FavoritesFailureState extends FavoriteStates {
  final String errorMessage;
  FavoritesFailureState({required this.errorMessage});
}

class FavoritesLoadedState extends FavoriteStates {
  final Map<String, bool> favorites;
  FavoritesLoadedState({required this.favorites});
}

class FavoritesMoviesLoading extends FavoriteStates {}

class FavoritesMoviesLoaded extends FavoriteStates {
  final List<MovieModel> movies;
  FavoritesMoviesLoaded(this.movies);
}

class FavoritesMoviesError extends FavoriteStates {
  final String message;
  FavoritesMoviesError(this.message);
}

class FavoritesMoviesEmpty extends FavoriteStates {}
