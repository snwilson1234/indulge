import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
        _makeListInserts(batch);
        _makeRestaurantInserts(batch);
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

  static void _createReviewTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS Review');
    batch.execute('''
    CREATE TABLE Review(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      restaurantId INTEGER,
      rating REAL,
      comment TEXT,
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

  static void _makeReviewInserts(Batch batch) {
    batch.execute('''
    INSERT INTO Review values(1,1,5,"My favorite place to eat!");
    ''');
    batch.execute('''
    INSERT INTO Review values(2,2,4,"Waited a little too long, but food was great!");
    ''');

  }

  static void _makeRestaurantInserts(Batch batch) {
    batch.execute('''
    INSERT INTO DummyRestaurant values(1,"Taco Tavern",1);
    ''');
    batch.execute('''
    INSERT INTO DummyRestaurant values(2,"Pasta Palace",1);
    ''');
    batch.execute('''
    INSERT INTO DummyRestaurant values(3,"Sushi Spot",2);
    ''');
  }

  static void _makeListInserts(Batch batch) {
    batch.execute('''
    INSERT INTO RestaurantList values(1,"Been There");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(2,"Chinese");
    ''');
  } 

  static void _deleteAllReviews(Batch batch) {

  }

  static void _deleteAllLists(Batch batch) {
    
  }

  static void _deleteAllRestaurants(Batch batch) {
    
  }
}