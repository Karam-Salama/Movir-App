import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
}
