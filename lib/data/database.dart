import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/event.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Future<Database> get db async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'holatimer.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE events (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            target_date TEXT NOT NULL,
            type TEXT NOT NULL,
            display_unit TEXT NOT NULL,
            created_at TEXT NOT NULL,
            notification_time TEXT,
            is_active INTEGER NOT NULL DEFAULT 1
          )
        ''');
        await db.execute('''
          CREATE TABLE photos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            event_id INTEGER NOT NULL,
            file_path TEXT NOT NULL,
            taken_at TEXT NOT NULL,
            caption TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE photos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              event_id INTEGER NOT NULL,
              file_path TEXT NOT NULL,
              taken_at TEXT NOT NULL,
              caption TEXT
            )
          ''');
        }
      },
    );
  }

  Future<int> insertEvent(Event event) async {
    final database = await db;
    return database.insert('events', event.toMap());
  }

  Future<List<Event>> getEvents() async {
    final database = await db;
    final maps = await database.query(
      'events',
      where: 'is_active = ?',
      whereArgs: [1],
      orderBy: 'created_at DESC',
    );
    return maps.map(Event.fromMap).toList();
  }

  Future<Event?> getEvent(int id) async {
    final database = await db;
    final maps = await database.query('events', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Event.fromMap(maps.first);
  }

  Future<void> updateEvent(Event event) async {
    final database = await db;
    await database.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> deleteEvent(int id) async {
    final database = await db;
    await database.update(
      'events',
      {'is_active': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
