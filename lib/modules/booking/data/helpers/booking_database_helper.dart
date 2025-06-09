import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/booking_model.dart';

class BookingDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bookings.db');

    return await openDatabase(
      path,
      version: 7,
      onCreate: _createDB,
    );
  }

  static Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE bookings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId TEXT,
      movieId TEXT,
      movieName TEXT,
      movieCategories TEXT,
      moviePoster TEXT,
      movieDuration TEXT,
      cinemaId TEXT,
      cinemaName TEXT,
      date TEXT,
      time TEXT,
      seats TEXT,
      totalPrice INTEGER,
      UNIQUE(userId, movieId, cinemaId, date, time)
    )
  ''');
  }

  static Future<bool> hasExistingBooking({
    required String userId,
    required String movieId,
    required String cinemaId,
    required String date,
    required String time,
  }) async {
    final db = await database;
    final result = await db.query(
      'bookings',
      where:
          'userId = ? AND movieId = ? AND cinemaId = ? AND date = ? AND time = ?',
      whereArgs: [userId, movieId, cinemaId, date, time],
    );
    return result.isNotEmpty;
  }

  // أضفنا هذه الدالة للبحث عن المقاعد المحجوزة
  static Future<List<String>> getReservedSeats({
    required String movieId,
    required String cinemaId,
    required String date,
    required String time,
  }) async {
    final db = await database;
    final result = await db.query(
      'bookings',
      columns: ['seats'],
      where: 'movieId = ? AND cinemaId = ? AND date = ? AND time = ?',
      whereArgs: [movieId, cinemaId, date, time],
    );

    final reservedSeats = <String>[];
    for (var row in result) {
      final seatsString = row['seats'] as String;
      final seats = seatsString.split(',');
      reservedSeats.addAll(seats);
    }

    return reservedSeats;
  }

  // أضفنا هذه الدالة للتحقق من توفر المقاعد
  static Future<bool> areSeatsAvailable({
    required String movieId,
    required String cinemaId,
    required String date,
    required String time,
    required List<String> seatsToCheck,
  }) async {
    final reservedSeats = await getReservedSeats(
      movieId: movieId,
      cinemaId: cinemaId,
      date: date,
      time: time,
    );

    return !seatsToCheck.any((seat) => reservedSeats.contains(seat));
  }

  static Future<void> insertBooking(Booking booking) async {
    final db = await database;
    await db.insert('bookings', booking.toMap());
  }

  static Future<List<Booking>> getAllBookings() async {
    final db = await database;
    final result = await db.query('bookings');
    return result.map((map) => Booking.fromMap(map)).toList();
  }

  static Future<void> clearBookings() async {
    final db = await database;
    await db.delete('bookings');
  }
}
