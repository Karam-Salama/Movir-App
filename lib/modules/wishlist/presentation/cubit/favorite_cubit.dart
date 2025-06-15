// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/wishlist/domain/repos/favorite_repo.dart';

import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  final FavoriteRepo favoriteRepo;
  FavoriteCubit({required this.favoriteRepo}) : super(FavoritesInitialState()) {
    loadFavorites(); // تحميل المفضلة عند الإنشاء
  }

  Map<String, bool> favorites = {};

  Future<void> loadFavorites() async {
    emit(FavoritesLoadingState());
    try {
      final result = await favoriteRepo.getFavorites();
      result.fold(
        (error) => emit(FavoritesFailureState(errorMessage: error)),
        (favoritesList) {
          favorites = {for (var movie in favoritesList) movie.movieId: true};
          emit(FavoritesLoadedState(favorites: favorites));
        },
      );
    } catch (e) {
      emit(FavoritesFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> addMovieToFavorites({required String movieId}) async {
    try {
      emit(FavoritesLoadingState());
      final result = await favoriteRepo.addMovieToFavorites(movieId: movieId);
      result.fold(
        (error) => emit(FavoritesFailureState(errorMessage: error)),
        (success) {
          favorites[movieId] = true;
          emit(FavoritesSuccessState());
        },
      );
    } catch (e) {
      emit(FavoritesFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> removeMovieFromFavorites({required String movieId}) async {
    emit(FavoritesLoadingState());
    final result =
        await favoriteRepo.removeMovieFromFavorites(movieId: movieId);
    result.fold(
      (error) => emit(FavoritesFailureState(errorMessage: error)),
      (success) {
        favorites.remove(movieId);
        emit(FavoritesSuccessState());
      },
    );
  }

  bool isMovieInFavorites(String movieId) {
    return favorites.containsKey(movieId);
  }
}
