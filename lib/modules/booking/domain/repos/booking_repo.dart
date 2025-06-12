import 'package:dartz/dartz.dart';
import '../../data/model/booking_model.dart';
import '../../data/server/models/cinema_model.dart';

abstract class BookingRepo {
  Future<Either<String, List<CinemaModel>>> getCinemas();
  Future<Either<String, List<DateTime>>> getAvailableDates();
  Future<Either<String, List<String>>> getAvailableTimes(DateTime date);

  Future<Either<String, List<String>>> getReservedSeats({
    required String movieId,
    required String cinemaId,
    required DateTime date,
    required String time,
  });

  Future<Either<String, void>> bookMovie(Booking booking);
  Stream<List<Booking>> getUserBookings(String userId);
  Future<Either<String, bool>> areSeatsAvailable({
    required String movieId,
    required String cinemaId,
    required DateTime date,
    required String time,
    required List<String> seats,
  });

  Future<Either<String, void>> deleteBooking(String bookingId);
}
