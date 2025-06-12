import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Booking {
  final String? id;
  final String compositeKey;
  final String userId;
  final String movieId;
  final String movieName;
  final String moviePoster;
  final List<String> movieCategories;
  final String movieDuration;
  final String cinemaId;
  final String cinemaName;
  final DateTime date;
  final String time;
  final List<String> seats;
  final int totalPrice;
  final DateTime createdAt;
  final String? paymentId;

  Booking({
    this.id,
    required this.userId,
    required this.movieId,
    required this.movieName,
    required this.moviePoster,
    required this.movieCategories,
    required this.movieDuration,
    required this.cinemaId,
    required this.cinemaName,
    required this.date,
    required this.time,
    required this.seats,
    int? totalPrice,
    DateTime? createdAt,
    this.paymentId,
  })  : createdAt = createdAt ?? DateTime.now(),
        totalPrice = totalPrice ?? seats.length * 40,
        compositeKey =
            '$movieId-$cinemaId-${DateFormat('d/M/yyyy').format(date)}-$time-${createdAt?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch}';

  factory Booking.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final dateFormat = DateFormat('d/M/yyyy');

    return Booking(
      id: doc.id,
      userId: data['userId'] ?? '',
      movieId: data['movieId'] ?? '',
      movieName: data['movieName'] ?? '',
      moviePoster: data['moviePoster'] ?? '',
      movieCategories: List<String>.from(data['movieCategories'] ?? []),
      movieDuration: data['movieDuration'] ?? '',
      cinemaId: data['cinemaId'] ?? '',
      cinemaName: data['cinemaName'] ?? '',
      date: dateFormat.parse(data['date']),
      time: data['time'] ?? '',
      seats: List<String>.from(data['seats'] ?? []),
      totalPrice: (data['totalPrice'] as num?)?.toInt() ?? 0,
      paymentId: data['paymentId'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    final dateFormat = DateFormat('d/M/yyyy');

    return {
      'userId': userId,
      'movieId': movieId,
      'movieName': movieName,
      'moviePoster': moviePoster,
      'movieCategories': movieCategories,
      'movieDuration': movieDuration,
      'cinemaId': cinemaId,
      'cinemaName': cinemaName,
      'date': dateFormat.format(date),
      'time': time,
      'seats': seats,
      'totalPrice': totalPrice,
      'createdAt': Timestamp.fromDate(createdAt),
      'paymentId': paymentId,
      'compositeKey': compositeKey,
    };
  }
}
