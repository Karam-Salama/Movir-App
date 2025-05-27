import 'package:dartz/dartz.dart';

import 'package:movir_app/modules/home/data/models/movie_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/errors/api_exceptions.dart';
import '../../../../core/utils/api_const.dart';
import '../../domain/search_repo.dart';

class SearchRepoImple implements SearchRepo {
  final ApiConsumer api;
  SearchRepoImple({required this.api});
  @override
  Future<Either<String, List<MovieModel>>> searchMovies(
      {required String movieQuery}) async {
    try {
      final response = await api.get(APIEndPoints.getMovieBySearch(movieQuery));
      final List<dynamic> data = response[ApiKeys.results];
      return Right(data.map((x) => MovieModel.fromJson(x)).toList());
    } on ServerException catch (e) {
      return Left(e.errModel.statusMessage);
    }
  }
}
