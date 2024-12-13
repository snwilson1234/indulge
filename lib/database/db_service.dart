import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      print("Database found. Opening...");
      return _database!;
    } else {
      // Initialize database
      print("Database not found. Initializing...");
      _database = await _initDatabase();
      print("intiialized the database.");
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
      onConfigure: _onConfigure,
      onCreate: (db, version) async {
        // create our tables
        var batch = db.batch();
        _createRestaurantListTable(batch);

        _createRestaurantTable(batch);
        _createReviewTable(batch);
        _makeListInserts(batch);
        _makeRestaurantTableInserts(batch);
        _makeReviewInserts(batch);
        // TODO: add more tables & dummy data
        await batch.commit();
        print("Successfully committed batch");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print("tried to upgrade!");
      }
    );
    return _database!;
  }

  static Future _onConfigure(Database db) async {
    print("configuring..");
    await db.execute('PRAGMA foreign_keys = ON;');
  }

  static void _createReviewTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS Review');
    batch.execute('''
    CREATE TABLE Review(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      restaurantId INTEGER,
      restaurantName TEXT,
      rating REAL,
      comment TEXT,
      FOREIGN KEY (restaurantId) REFERENCES Restaurant(id) ON DELETE CASCADE
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

  static void _makeReviewInserts(Batch batch) {
    batch.execute('''
    INSERT INTO Review values(1,1,"Taco Tavern",5,"My favorite place to eat!");
    ''');

  }

  static void _makeListInserts(Batch batch) {
    batch.execute('''
    INSERT INTO RestaurantList values(1,"Been There");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(2,"Chinese");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(3,"Mexican");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(4,"Italian");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(5,"Japanese");
    ''');
  } 

  static void _createRestaurantTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS Restaurant');
    batch.execute('''
      CREATE TABLE Restaurant (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        distance TEXT NOT NULL,
        type TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        globalRating REAL NOT NULL,
        listId INTEGER,
        reviewed INTEGER,
        FOREIGN KEY (listId) REFERENCES RestaurantList(id) on DELETE CASCADE
      )
    ''');
  }

  static void _makeRestaurantTableInserts(Batch batch) {
    batch.insert('Restaurant', {
      'name': 'Taco Tavern',
      'distance': '1.5 mi',
      'type': 'Mexican',
      'imageUrl': 'https://static.stacker.com/s3fs-public/41THDS_96.png',
      'globalRating': 4.8,
      'listId': null,
      'reviewed': 1,
    });

    batch.insert('Restaurant', {
      'name': 'Pasta Palace',
      'distance': '2.3 mi',
      'type': 'Italian',
      'imageUrl': 'https://goodfoodpittsburgh.com/wp-content/uploads/2020/01/83578012_597313894148871_4528116092105059721_n-820x1024.jpg',
      'globalRating': 4.5,
      'listId': null,
      'reviewed': 0,
    });

    batch.insert('Restaurant', {
      'name': 'Sushi Spot',
      'distance': '3.2 mi',
      'type': 'Japanese',
      'imageUrl': 'https://static.stacker.com/s3fs-public/styles/sar_screen_maximum_large/s3/83JKTK_113.png',
      'globalRating': 4.2,
      'listId': null,
      'reviewed': 0
    });

    batch.insert('Restaurant', {
      'name': 'Hibachi House',
      'distance': '3.2 mi',
      'type': 'Japanese',
      'imageUrl': 'https://static.stacker.com/s3fs-public/styles/sar_screen_maximum_large/s3/83JKTK_113.png',
      'globalRating': 4.2,
      'listId': 5,
      'reviewed': 0
    });

    batch.insert('Restaurant', {
      'name': 'Umami Universe',
      'distance': '3.2 mi',
      'type': 'Japanese',
      'imageUrl': 'https://static.stacker.com/s3fs-public/styles/sar_screen_maximum_large/s3/83JKTK_113.png',
      'globalRating': 4.2,
      'listId': 5,
      'reviewed': 0
    });
  }




  static void _deleteAllReviews(Batch batch) {

  }

  static void _deleteAllLists(Batch batch) {
    
  }

  static void _deleteAllRestaurants(Batch batch) {
    
  }
}