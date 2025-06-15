import 'package:dartz/dartz.dart';

import '../../data/models/favorite_model.dart';

abstract class FavoriteRepo {
  // ! Wishlist Data
  Future<Either<String, bool>> addMovieToFavorites({required String movieId});
  Future<Either<String, bool>> removeMovieFromFavorites(
      {required String movieId});

  Future<Either<String, List<FavoriteModel>>> getFavorites();
}
