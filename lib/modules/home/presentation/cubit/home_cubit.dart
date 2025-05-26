import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repos/home_repo.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepo homeRepo;
  String selectedCategoryId = '28'; // Default category

  HomeCubit({required this.homeRepo}) : super(HomeInitialState());

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

  Future<void> getCategoriesData() async {
    emit(CategoriesLoadingState());
    final response = await homeRepo.getCategoriesData();
    response.fold(
      (failure) => emit(CategoriesFailureState(errorMessage: failure)),
      (categories) => emit(CategoriesSuccessState(categories: categories)),
    );
  }

  Future<void> getMoviesListByCategoryId({required String categoryId}) async {
    selectedCategoryId = categoryId;
    emit(MoviesListLoadingState());
    final response = await homeRepo.getMoviesListByCategoryId(
      categoryId: categoryId,
    );
    response.fold(
      (failure) => emit(MoviesListFailureState(errorMessage: failure)),
      (movies) => emit(MoviesListSuccessState(movies: movies)),
    );
  }

  Future<void> getMovieDetailsById({required String movieId}) async {
    emit(MovieDetailsLoadingState());
    final response = await homeRepo.getMovieDetailsById(movieId: movieId);
    response.fold(
      (failure) => emit(MovieDetailsFailureState(errorMessage: failure)),
      (movieDetails) => emit(MovieDetailsSuccessState(movieDetails)),
    );
  }

  Future<void> getTopRatedMovies() async {
    emit(TopRatedMoviesLoadingState());
    final response = await homeRepo.getTopRatedMovies();
    response.fold(
      (failure) => emit(TopRatedMoviesFailureState(errorMessage: failure)),
      (movies) => emit(TopRatedMoviesSuccessState(movies: movies)),
    );
  }

  Future<void> getPopularMovies() async {
    emit(PopularMoviesLoadingState());
    final response = await homeRepo.getPopularMovies();
    response.fold(
      (failure) => emit(PopularMoviesFailureState(errorMessage: failure)),
      (movies) => emit(PopularMoviesSuccessState(movies: movies)),
    );
  }

  Future<void> getUpcomingMovies() async {
    emit(UpcomingMoviesLoadingState());
    final response = await homeRepo.getUpcomingMovies();
    response.fold(
      (failure) => emit(UpcomingMoviesFailureState(errorMessage: failure)),
      (movies) => emit(UpcomingMoviesSuccessState(movies: movies)),
    );
  }

  Future<void> getNowPlayingMovies() async {
    emit(NowPlayingMoviesLoadingState());
    final response = await homeRepo.getNowPlayingMovies();
    response.fold(
      (failure) => emit(NowPlayingMoviesFailureState(errorMessage: failure)),
      (movies) => emit(NowPlayingMoviesSuccessState(movies: movies)),
    );
  }

  Future<void> getTrendingMovies() async {
    emit(TrendingMoviesLoadingState());
    final response = await homeRepo.getTrendingMovies();
    response.fold(
      (failure) => emit(TrendingMoviesFailureState(errorMessage: failure)),
      (movies) => emit(TrendingMoviesSuccessState(movies: movies)),
    );
  }

  Future<void> getMovieCrew({required String movieId}) async {
    emit(MovieCrewLoadingState());
    final response = await homeRepo.getMovieCrew(movieId: movieId);
    response.fold(
      (failure) => emit(MovieCrewFailureState(errorMessage: failure)),
      (crew) => emit(MovieCrewSuccessState(crew: crew)),
    );
  }

  Future<void> getMovieReviews({required String movieId}) async {
    emit(MovieReviewsLoadingState());
    final response = await homeRepo.getMovieReviews(movieId: movieId);
    response.fold(
      (failure) => emit(MovieReviewsFailureState(errorMessage: failure)),
      (reviews) => emit(MovieReviewsSuccessState(reviews: reviews)),
    );
  }
}
