import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

// Our Main database service, the sqflite way.
// Responsible for creating DB tables and making initial inserts.
class DatabaseService {
  static Database? _database;
  
  static Future<Database> get database async {
    if (_database != null) {
      // open a DB session if already initialized
      return _database!;
    } else {
      // otherwise, initialize the DB and open session
      print("Database not found. Initializing...");
      _database = await _initDatabase();
      print("Initialized the database.");
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
        var batch = db.batch();

        // creating our tables
        _createRestaurantListTable(batch);
        _createRestaurantTable(batch);
        _createRestaurantListHelperTable(batch);
        _createReviewTable(batch);
        _createAccountInfoTable(batch);
        _createPreferencesTable(batch);
        _createDietaryRestrictionsTable(batch);
        _createPriceTable(batch);

        // make initial data inserts
        // _makeAccountInfoInsert(batch);
        // _makeDietaryRestrictionsInsert(batch);
        // _makePreferencesInsert(batch);
        // _makePriceInsert(batch);
        _makeListInserts(batch);
        _makeRestaurantTableInserts(batch);
        _makeReviewInserts(batch);

        // commit the transaction
        await batch.commit();
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
      name TEXT NOT NULL UNIQUE
      );'''
    );
  }

  static void _createRestaurantListHelperTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS ListHelper');
    batch.execute('''
    CREATE TABLE ListHelper(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      listId INTEGER,
      restaurantId INTEGER,
      FOREIGN KEY (listId) REFERENCES RestaurantList(id),
      FOREIGN KEY (restaurantId) REFERENCES Restaurant(id)
      );'''
    );
  }

  static void _createAccountInfoTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS AccountInfo');
    batch.execute('''
      CREATE TABLE AccountInfo(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        username TEXT,
        password TEXT,
        email TEXT,
        reviewed INTEGER,
        saved INTEGER,
        radius REAL
      );'''
    );
  }

  static void _createPreferencesTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS Preferences');
    batch.execute('''
      CREATE TABLE Preferences(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        userId INTEGER,
        preference STRING,
        FOREIGN KEY (userId) REFERENCES AccountInfo(id) ON DELETE CASCADE
      );
    ''');
  }

  static void _createDietaryRestrictionsTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS DietaryRestrictions');
    batch.execute('''
      CREATE TABLE DietaryRestrictions(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        userId INTEGER,
        restriction STRING,
        FOREIGN KEY (userId) REFERENCES AccountInfo(id) ON DELETE CASCADE
      );
    ''');
  }

  static void _createPriceTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS Price');
    batch.execute('''
      CREATE TABLE Price(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        userId INTEGER,
        price INTEGER,
        FOREIGN KEY (userId) REFERENCES AccountInfo(id) ON DELETE CASCADE
      );
    ''');
  }

  static void _makeAccountInfoInsert(Batch batch) {
    batch.execute('''
      INSERT INTO AccountInfo values(1, "user", "pass", "user@email.com", 0, 0, 8);
    ''');
  }

  static void _makePriceInsert(Batch batch) {
    batch.execute('''
      INSERT INTO Price values(1, 1, 1);
    ''');
    batch.execute('''
      INSERT INTO Price values(2, 1, 1);
    ''');
  }

  static void _makePreferencesInsert(Batch batch) {
    batch.execute('''
      INSERT INTO Preferences values(1, 1, "Italian");
    ''');
    batch.execute('''
      INSERT INTO Preferences values(2, 1, "Peruvian");
    ''');
    batch.execute('''
      INSERT INTO Preferences values(3, 1, "Middle-Eastern");
    ''');
  }
  static void _makeDietaryRestrictionsInsert(Batch batch) {
        batch.execute('''
      INSERT INTO DietaryRestrictions values(1, 1, "Dairy Allergy");
    ''');
    batch.execute('''
      INSERT INTO DietaryRestrictions values(2, 1, "Vegan");
    ''');
  }
  

  static void _makeReviewInserts(Batch batch) {

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
    batch.execute('''
    INSERT INTO RestaurantList values(6,"Peruvian");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(7,"French");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(8,"Spanish");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(9,"American");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(10,"Polish");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(11,"Middle-Eastern");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(12,"Greek");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(13,"Ethiopian");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(14,"Desserts");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(15,"Larger Portions");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(16,"Fancy");
    ''');
    batch.execute('''
    INSERT INTO RestaurantList values(17,"Family-Friendly");
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
        restrictions  TEXT NOT NULL,
        globalRating REAL NOT NULL,
        reviewed INTEGER,
        indulged INTEGER,
        viewed INTEGER
      )
    ''');
  }

  static void _makeRestaurantTableInserts(Batch batch) {
    batch.insert('Restaurant', {
      'name': 'Taco Tavern',
      'distance': '1.5 mi',
      'type': 'Mexican',
      'imageUrl': 'https://static.stacker.com/s3fs-public/41THDS_96.png',
      'restrictions': '',
      'globalRating': 4.8,
      'reviewed': 0,
      'indulged': 0,
      'viewed' : 0
    });

    batch.insert('Restaurant', {
      'name': 'Pasta Palace',
      'distance': '2.3 mi',
      'type': 'Italian',
      'imageUrl': 'https://goodfoodpittsburgh.com/wp-content/uploads/2020/01/83578012_597313894148871_4528116092105059721_n-820x1024.jpg',
      'restrictions': 'Dairy Allergy',
      'globalRating': 4.5,
      'reviewed': 0,
      'indulged': 0,
      'viewed' : 0
    });

    batch.insert('Restaurant', {
      'name': 'Sushi Spot',
      'distance': '3.2 mi',
      'type': 'Japanese',
      'imageUrl': 'https://static.stacker.com/s3fs-public/styles/sar_screen_maximum_large/s3/83JKTK_113.png',
      'restrictions': 'Peanut Allergy',
      'globalRating': 4.2,
      'reviewed': 0,
      'indulged': 0,
      'viewed' : 0
    });

    batch.insert('Restaurant', {
      'name': 'Hibachi House',
      'distance': '3.2 mi',
      'type': 'Japanese',
      'imageUrl': 'https://cdn.popmenu.com/image/upload/c_limit,f_auto,h_1920,q_auto,w_1920/v1582523428/qx3wrhvl3d8ngg2b0n8c.jpg',
      'restrictions': 'Peanut Allergy',
      'globalRating': 4.2,
      'reviewed': 0,
      'indulged': 0,
      'viewed' : 0
    });

    batch.insert('Restaurant', {
      'name': 'Umami Universe',
      'distance': '3.2 mi',
      'type': 'Japanese',
      'imageUrl': 'https://resizer.otstatic.com/v2/photos/xlarge/1/24904317.jpg',
      'restrictions': 'Peanut Allergy',
      'globalRating': 4.2,
      'reviewed': 0,
      'indulged': 0,
      'viewed' : 0
    });
  }

}