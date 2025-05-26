import 'package:dartz/dartz.dart';
import 'package:movir_app/modules/home/data/models/category_model.dart';

import '../../data/models/crew_model.dart';
import '../../data/models/movie_details_model .dart';
import '../../data/models/movie_model.dart';
import '../../data/models/review_model.dart';

abstract class HomeRepo {
  // ! Home Data
  Future<Either<String, List<CategoryModel>>> getCategoriesData();
  Future<Either<String, List<MovieModel>>> getMoviesListByCategoryId(
      {required String categoryId});

  Future<Either<String, MovieDetailsModel>> getMovieDetailsById(
      {required String movieId});

  Future<Either<String, List<MovieModel>>> getTopRatedMovies();
  Future<Either<String, List<MovieModel>>> getPopularMovies();
  Future<Either<String, List<MovieModel>>> getUpcomingMovies();
  Future<Either<String, List<MovieModel>>> getNowPlayingMovies();
  Future<Either<String, List<MovieModel>>> getTrendingMovies();

  Future<Either<String, List<CrewModel>>> getMovieCrew(
      {required String movieId});

  Future<Either<String, List<MovieReviewModel>>> getMovieReviews(
      {required String movieId});
}
