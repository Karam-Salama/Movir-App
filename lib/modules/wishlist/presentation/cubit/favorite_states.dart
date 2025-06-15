import 'package:flutter/material.dart';

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
