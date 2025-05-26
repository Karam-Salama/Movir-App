class Booking {
  final int? id;
  final String movieName;
  final String moviePoster;
  final List<String> movieCategories;
  final String movieDuration;
  final String cinemaName;
  final String date;
  final String time;
  final List<String> seats;
  final int totalPrice;

  Booking({
    this.id,
    required this.movieName,
    required this.moviePoster,
    required this.movieCategories,
    required this.movieDuration,
    required this.cinemaName,
    required this.date,
    required this.time,
    required this.seats,
    int? totalPrice,
  }) : totalPrice = totalPrice ?? _calculateTotalPrice(seats);

  static int _calculateTotalPrice(List<String> seats) {
    const pricePerSeat = 40;
    return seats.length * pricePerSeat;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'movieName': movieName,
      'moviePoster': moviePoster,
      'movieCategories': movieCategories.join(','),
      'movieDuration': movieDuration,
      'cinemaName': cinemaName,
      'date': date,
      'time': time,
      'seats': seats.join(','),
      'totalPrice': totalPrice,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      movieName: map['movieName'],
      moviePoster: map['moviePoster'],
      movieCategories: (map['movieCategories'] as String).split(','),
      movieDuration: map['movieDuration'],
      cinemaName: map['cinemaName'],
      date: map['date'],
      time: map['time'],
      seats: (map['seats'] as String).split(','),
      totalPrice: map['totalPrice'],
    );
  }
}
