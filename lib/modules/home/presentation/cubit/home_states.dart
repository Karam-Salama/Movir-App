import 'package:flutter/material.dart';
import 'package:movir_app/modules/home/data/models/category_model.dart';
import 'package:movir_app/modules/home/data/models/movie_details_model%20.dart';
import 'package:movir_app/modules/home/data/models/movie_model.dart';

import '../../data/models/crew_model.dart';
import '../../data/models/review_model.dart';

@immutable
sealed class HomeStates {}

class HomeInitialState extends HomeStates {}

class CategoriesLoadingState extends HomeStates {}

class CategoriesSuccessState extends HomeStates {
  final List<CategoryModel> categories;
  CategoriesSuccessState({required this.categories});
}

class CategoriesFailureState extends HomeStates {
  final String errorMessage;
  CategoriesFailureState({required this.errorMessage});
}

class MoviesListLoadingState extends HomeStates {}

class MoviesListSuccessState extends HomeStates {
  final List<MovieModel> movies;
  MoviesListSuccessState({required this.movies});
}

class MoviesListFailureState extends HomeStates {
  final String errorMessage;
  MoviesListFailureState({required this.errorMessage});
}

class MovieDetailsLoadingState extends HomeStates {}

class MovieDetailsSuccessState extends HomeStates {
  final MovieDetailsModel movieDetailsModel;

  MovieDetailsSuccessState(this.movieDetailsModel);
}

class MovieDetailsFailureState extends HomeStates {
  final String errorMessage;
  MovieDetailsFailureState({required this.errorMessage});
}

class TopRatedMoviesLoadingState extends HomeStates {}

class TopRatedMoviesSuccessState extends HomeStates {
  final List<MovieModel> movies;
  TopRatedMoviesSuccessState({required this.movies});
}

class TopRatedMoviesFailureState extends HomeStates {
  final String errorMessage;
  TopRatedMoviesFailureState({required this.errorMessage});
}

class PopularMoviesLoadingState extends HomeStates {}

class PopularMoviesSuccessState extends HomeStates {
  final List<MovieModel> movies;
  PopularMoviesSuccessState({required this.movies});
}

class PopularMoviesFailureState extends HomeStates {
  final String errorMessage;
  PopularMoviesFailureState({required this.errorMessage});
}

class UpcomingMoviesLoadingState extends HomeStates {}

class UpcomingMoviesSuccessState extends HomeStates {
  final List<MovieModel> movies;
  UpcomingMoviesSuccessState({required this.movies});
}

class UpcomingMoviesFailureState extends HomeStates {
  final String errorMessage;
  UpcomingMoviesFailureState({required this.errorMessage});
}

class NowPlayingMoviesLoadingState extends HomeStates {}

class NowPlayingMoviesSuccessState extends HomeStates {
  final List<MovieModel> movies;
  NowPlayingMoviesSuccessState({required this.movies});
}

class NowPlayingMoviesFailureState extends HomeStates {
  final String errorMessage;
  NowPlayingMoviesFailureState({required this.errorMessage});
}

class TrendingMoviesLoadingState extends HomeStates {}

class TrendingMoviesSuccessState extends HomeStates {
  final List<MovieModel> movies;
  TrendingMoviesSuccessState({required this.movies});
}

class TrendingMoviesFailureState extends HomeStates {
  final String errorMessage;
  TrendingMoviesFailureState({required this.errorMessage});
}

class MovieCrewLoadingState extends HomeStates {}

class MovieCrewSuccessState extends HomeStates {
  final List<CrewModel> crew;
  MovieCrewSuccessState({required this.crew});
}

class MovieCrewFailureState extends HomeStates {
  final String errorMessage;
  MovieCrewFailureState({required this.errorMessage});
}

class MovieReviewsLoadingState extends HomeStates {}

class MovieReviewsSuccessState extends HomeStates {
  final List<MovieReviewModel> reviews;
  MovieReviewsSuccessState({required this.reviews});
}

class MovieReviewsFailureState extends HomeStates {
  final String errorMessage;
  MovieReviewsFailureState({required this.errorMessage});
}
