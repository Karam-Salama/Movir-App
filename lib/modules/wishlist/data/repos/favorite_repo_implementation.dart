import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/api_exceptions.dart';
import '../../../../core/service/service_firebase_firestore.dart';
import '../../../../core/utils/api_const.dart';
import '../../domain/repos/favorite_repo.dart';
import '../models/favorite_model.dart';

class FavoriteRepoImplementation implements FavoriteRepo {
  final FirabaseFirestoreService firabaseFirestoreService;
  FavoriteRepoImplementation({required this.firabaseFirestoreService});

  @override
  Future<Either<String, bool>> addMovieToFavorites({
    required String movieId,
  }) async {
    try {
      bool isExist = await firabaseFirestoreService.checkIfDataExists(
          path: FirebaseEndpoints.addMovieToFavorites, documentId: movieId);
      if (isExist) {
        return const Left("Movie already in favorites");
      } else {
        FavoriteModel favoriteModel = FavoriteModel(
          movieId: movieId,
          createdAt: DateTime.now().toIso8601String(),
          isFavorite: true,
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        );
        await firabaseFirestoreService.addData(
          path: FirebaseEndpoints.addMovieToFavorites,
          data: favoriteModel.toJson(),
          documentId: movieId,
        );

        return Right(true);
      }
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, bool>> removeMovieFromFavorites({
    required String movieId,
  }) async {
    try {
      // Assuming you have a method to remove data from Firestore
      await firabaseFirestoreService.deleteData(
        path: FirebaseEndpoints.removeMovieFromFavorites,
        documentId: movieId,
      );
      return const Right(true);
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<FavoriteModel>>> getFavorites() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final snapshot = await firabaseFirestoreService.firestore
          .collection(FirebaseEndpoints.addMovieToFavorites)
          .where('userId', isEqualTo: userId)
          .get();

      final favorites = snapshot.docs
          .map((doc) => FavoriteModel.fromJson(doc.data()))
          .toList();

      return Right(favorites);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Failed to load favorites');
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }
}
