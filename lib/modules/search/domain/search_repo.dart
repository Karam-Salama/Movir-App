import 'package:dartz/dartz.dart';

import '../../home/data/models/movie_model.dart';

abstract class SearchRepo {
  Future<Either<String, List<MovieModel>>> searchMovies(
      {required String movieQuery});
}
