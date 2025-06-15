// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/home/data/models/movie_model.dart';
import 'package:movir_app/modules/wishlist/domain/repos/favorite_repo.dart';

import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  final FavoriteRepo favoriteRepo;
  FavoriteCubit({required this.favoriteRepo}) : super(FavoritesInitialState()) {
    loadFavorites(); // تحميل المفضلة عند الإنشاء
  }

  static Map<int, String> genreMap = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western",
  };

  String getCategoryNamesString(List<int> ids) {
    return ids.map((id) => genreMap[id] ?? 'Unknown').join(', ');
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
          loadFavoriteMovies();
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
        loadFavoriteMovies();
        emit(FavoritesSuccessState());
      },
    );
  }

  bool isMovieInFavorites(String movieId) {
    return favorites.containsKey(movieId);
  }

  Future<void> loadFavoriteMovies() async {
    emit(FavoritesMoviesLoading());
    try {
      final result = await favoriteRepo.getFavoriteMoviesIds();
      result.fold(
        (error) => emit(FavoritesMoviesError(error)),
        (moviesIds) async {
          if (moviesIds.isEmpty) {
            emit(FavoritesMoviesEmpty());
            return;
          }

          final movies = <MovieModel>[];
          for (final movieId in moviesIds) {
            final movieResult =
                await favoriteRepo.getMovieDetailsById(movieId: movieId);
            movieResult.fold(
              (error) {
                print('Error loading movie $movieId: $error');
              },
              (movieDetails) {
                movies.add(movieDetails);
              },
            );
          }

          if (movies.isEmpty) {
            emit(FavoritesMoviesEmpty());
          } else {
            emit(FavoritesMoviesLoaded(movies));
          }
        },
      );
    } catch (e) {
      emit(FavoritesMoviesError('An unexpected error occurred'));
    }
  }
}
