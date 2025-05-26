abstract class APIConst {
  static const String apiKey = 'befe590df6486fccb958a1fe8c562e45';
  static const String accessToken =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiZWZlNTkwZGY2NDg2ZmNjYjk1OGExZmU4YzU2MmU0NSIsIm5iZiI6MTc0NDMxMDA2Ny45MTIsInN1YiI6IjY3ZjgwZjMzZGU1ZTRkZWM2MmFkNDdlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yDJjPUFeks1eE-lU74d0l1sVJCGKJQL-v-Z8WgKt8vc';
}

abstract class APIEndPoints {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String getCategories = '$baseUrl/genre/movie/list';
  static const String getTopRatedMovies = '$baseUrl/movie/top_rated';
  static const String getPopularMovies = '$baseUrl/movie/popular';
  static const String getUpcomingMovies = '$baseUrl/movie/upcoming';
  static const String getNowPlayingMovies = '$baseUrl/movie/now_playing';
  static const String getTrendingMovies = '$baseUrl/trending/movie/week';

  static String getMoviesListByCategoryId(String categoryId) =>
      '$baseUrl/discover/movie?with_genres=$categoryId';

  static String getMovieDetailsById(String movieId) =>
      '$baseUrl/movie/$movieId';

  static String getMovieCrew(String movieId) =>
      '$baseUrl/movie/$movieId/credits';
  static String getMovieReviews(String movieId) =>
      '$baseUrl/movie/$movieId/reviews';
}

class ApiKeys {
  static String statusCode = "status_code";
  static String statusMessage = "status_message";
  static String success = "success";
  static String data = "data";
  static String token = "token";
  static String authorization = "Authorization";
  static String accept = "Accept";
  static String lang = "lang";
  static String id = "id";
  static String name = "name";
  static String genres = "genres";
  static String results = "results";
  static String cast = "cast";

  // home
}

class APIImageUrls {
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
}

class FirebaseEndpoints {
  static String addUserData = 'users';
  static String getUserData = 'users';
  static String ifUserExists = 'users';
}
