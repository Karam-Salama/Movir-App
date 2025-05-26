import 'package:dartz/dartz.dart';

import '../../data/server/models/cinema_model.dart';

abstract class BookingRepo {
  Future<Either<String, List<CinemaModel>>> getCinemas();
  Future<Either<String, List<String>>> getAvailableTimes(DateTime date);
  Future<Either<String, List<DateTime>>> getAvailableDates();
}
