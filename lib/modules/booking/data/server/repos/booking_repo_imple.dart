import 'package:dartz/dartz.dart';

import 'package:movir_app/modules/booking/data/server/models/cinema_model.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../domain/repos/booking_repo.dart';

class BookingRepoImple extends BookingRepo {
  final ApiConsumer api;

  BookingRepoImple({required this.api});

  @override
  Future<Either<String, List<CinemaModel>>> getCinemas() async {
    try {
      // بيانات وهمية بدل ما نجيب من API أو SQLite
      List<CinemaModel> cinemas = [
        CinemaModel(id: 1, name: "VOX Cinema", location: "Cairo Festival City"),
        CinemaModel(id: 2, name: "Galaxy Cinema", location: "Mohandeseen"),
        CinemaModel(id: 3, name: "Zawya Cinema", location: "Downtown"),
      ];
      return Right(cinemas);
    } catch (e) {
      return Left("Failed to load cinemas: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, List<DateTime>>> getAvailableDates() async {
    try {
      final now = DateTime.now();
      List<DateTime> availableDates =
          List.generate(7, (index) => now.add(Duration(days: index)));
      return Right(availableDates);
    } catch (e) {
      return Left("Failed to load available dates: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, List<String>>> getAvailableTimes(DateTime date) async {
    try {
      List<String> times = [
        '10:00 AM',
        '12:00 PM',
        '2:00 PM',
        '4:00 PM',
        '6:00 PM',
        '8:00 PM',
      ];
      return Right(times);
    } catch (e) {
      return Left("Failed to load times: ${e.toString()}");
    }
  }
}
