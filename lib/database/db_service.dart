import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      // Initialize database
      _database = await _initDatabase();
      return _database!;
    }
  }

  static Future<Database> _initDatabase() async {
    if (_database != null) return _database!;

    // get db path
    final dbPath = join(await getDatabasesPath(), 'indulge.db');
    _database = await openDatabase(
      dbPath,
      version: 1,
      onConfigure: (db) async {
        // enable foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        // create our tables
        var batch = db.batch();
        _createRestaurantListTable(batch);
        _createDummyRestaurantTable(batch);
        _createReviewTable(batch);
        // TODO: add more tables
        await batch.commit();
      },
    );
    return _database!;
  }

  static void _createReviewTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS Review');
    batch.execute('''
    CREATE TABLE Review(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      restaurantId INTEGER,
      rating REAL,
      FOREIGN KEY (restaurantId) REFERENCES DummyRestaurant(id) ON DELETE CASCADE
      );'''
    );
  }

  static void _createRestaurantListTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS RestaurantList');
    batch.execute('''
    CREATE TABLE RestaurantList(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT
      );'''
    );
  }

  static void _createDummyRestaurantTable(Batch batch) {
    batch.execute(("DROP TABLE IF EXISTS DummyRestaurant"));
    batch.execute('''
    CREATE TABLE DummyRestaurant(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      restaurantName TEXT,
      listId INTEGER,
      FOREIGN KEY (listId) REFERENCES RestaurantList(id) on DELETE CASCADE
      );'''
    );
  }

}