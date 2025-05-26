import 'package:dartz/dartz.dart';

import 'package:movir_app/modules/home/data/models/category_model.dart';
import 'package:movir_app/modules/home/data/models/crew_model.dart';
import 'package:movir_app/modules/home/data/models/movie_details_model%20.dart';
import 'package:movir_app/modules/home/data/models/review_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/errors/api_exceptions.dart';
import '../../../../core/utils/api_const.dart';
import '../../domain/repos/home_repo.dart';
import '../models/movie_model.dart';

class HomeRepoImplment extends HomeRepo {
  final ApiConsumer api;

  HomeRepoImplment({required this.api});

  @override
  Future<Either<String, List<CategoryModel>>> getCategoriesData() async {
    try {
      final response = await api.get(APIEndPoints.getCategories);
      final List<dynamic> data = response[ApiKeys.genres];
      return Right(data.map((x) => CategoryModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<MovieModel>>> getMoviesListByCategoryId({
    required String categoryId,
  }) async {
    try {
      final response =
          await api.get(APIEndPoints.getMoviesListByCategoryId(categoryId));
      final List<dynamic> data = response[ApiKeys.results];
      return Right(data.map((x) => MovieModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, MovieDetailsModel>> getMovieDetailsById({
    required String movieId,
  }) async {
    try {
      final response = await api.get(APIEndPoints.getMovieDetailsById(movieId));
      return Right(MovieDetailsModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<MovieModel>>> getTopRatedMovies() async {
    try {
      final response = await api.get(APIEndPoints.getTopRatedMovies);
      final List<dynamic> data = response[ApiKeys.results];
      return Right(data.map((x) => MovieModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<MovieModel>>> getNowPlayingMovies() async {
    try {
      final response = await api.get(APIEndPoints.getNowPlayingMovies);
      final List<dynamic> data = response[ApiKeys.results];
      return Right(data.map((x) => MovieModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<MovieModel>>> getPopularMovies() async {
    try {
      final response = await api.get(APIEndPoints.getPopularMovies);
      final List<dynamic> data = response[ApiKeys.results];
      return Right(data.map((x) => MovieModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<MovieModel>>> getTrendingMovies() async {
    try {
      final response = await api.get(APIEndPoints.getTrendingMovies);
      final List<dynamic> data = response[ApiKeys.results];
      return Right(data.map((x) => MovieModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<MovieModel>>> getUpcomingMovies() async {
    try {
      final response = await api.get(APIEndPoints.getUpcomingMovies);
      final List<dynamic> data = response[ApiKeys.results];
      return Right(data.map((x) => MovieModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<CrewModel>>> getMovieCrew(
      {required String movieId}) async {
    try {
      final response = await api.get(APIEndPoints.getMovieCrew(movieId));
      final List<dynamic> data = response[ApiKeys.cast];
      return Right(data.map((x) => CrewModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }

  @override
  Future<Either<String, List<MovieReviewModel>>> getMovieReviews(
      {required String movieId}) async {
    try {
      final response = await api.get(APIEndPoints.getMovieReviews(movieId));
      final List<dynamic> data = response[ApiKeys.results];
      return Right(data.map((x) => MovieReviewModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }
}
