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
      version: 6,
      onCreate: _createDB,
    );
  }

  static Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        movieName TEXT,
        movieCategories TEXT,
        moviePoster TEXT,
        movieDuration TEXT,
        cinemaName TEXT,
        date TEXT,
        time TEXT,
        seats TEXT,
        totalPrice INTEGER
      )
    ''');
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


