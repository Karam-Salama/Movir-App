import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:movir_app/modules/booking/data/server/models/cinema_model.dart';
import '../../../domain/repos/booking_repo.dart';
import '../../model/booking_model.dart';

class BookingRepoImpl implements BookingRepo {
  final FirebaseFirestore _firestore;

  BookingRepoImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;
  @override
  Future<Either<String, List<CinemaModel>>> getCinemas() async {
    try {
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

  @override
  Future<Either<String, List<String>>> getReservedSeats({
    required String movieId,
    required String cinemaId,
    required DateTime date,
    required String time,
  }) async {
    try {
      final dateFormat = DateFormat('d/M/yyyy');
      final formattedDate = dateFormat.format(date);

      final query = _firestore.collection('bookings').where('compositeKey',
          isEqualTo: '$movieId-$cinemaId-$formattedDate-$time');

      final snapshot = await query.get();

      final reservedSeats = <String>[];
      for (final doc in snapshot.docs) {
        reservedSeats.addAll(List<String>.from(doc['seats']));
      }

      return Right(reservedSeats);
    } catch (e) {
      return Left("Failed to get reserved seats: ${e.toString()}");
    }
  }

  @override
  Stream<List<Booking>> getUserBookings(String userId) {
    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Booking.fromFirestore(doc)).toList());
  }

  @override
  Future<Either<String, bool>> areSeatsAvailable({
    required String movieId,
    required String cinemaId,
    required DateTime date,
    required String time,
    required List<String> seats,
  }) async {
    try {
      final reservedSeats = await getReservedSeats(
        movieId: movieId,
        cinemaId: cinemaId,
        date: date,
        time: time,
      );

      return reservedSeats.fold(
        (error) => Left(error),
        (seatsList) => Right(!seats.any(seatsList.contains)),
      );
    } catch (e) {
      return Left("Failed to check seat availability: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> bookMovie(Booking booking) async {
    try {
      final docRef = _firestore.collection('bookings').doc();
      await docRef.set(booking.toFirestore()..['id'] = docRef.id);
      return const Right(null);
    } catch (e) {
      return Left("Failed to book movie: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, void>> deleteBooking(String bookingId) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).delete();
      return const Right(null);
    } catch (e) {
      return Left("Failed to delete booking: ${e.toString()}");
    }
  }
}
