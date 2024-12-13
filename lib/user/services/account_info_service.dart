import 'package:indulge/database/db_service.dart';
import 'package:indulge/user/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;

class AccountInfoService {

  Future<int> _getUserId(Database db, String username) async {
    final user = await db.query(
      "AccountInfo",
      columns: ["userId"],
      where: "username = ?",
      whereArgs: [username]
    );

    return user[0]["userId"] as int;
  }

  Future<void> _insertPrices(Database db, int userId, List<int> prices) async {

    for (int price in prices) {
      await db.insert("Price", {
        "userId": userId,
        "price": price
      });
    }

  }

  Future<void> _insertPreferences(Database db, int userId, List<String> preferences) async {

    for (String preference in preferences) {
      await db.insert("Price", {
        "userId": userId,
        "preference": preference
      });
    }

  }

  Future<void> _insertDietaryRestrictions(Database db, int userId, List<String> restrictions) async {

    for (String restriction in restrictions) {
      await db.insert("Price", {
        "userId": userId,
        "restriction": restriction
      });
    }

  }

  Future<void> insertAccountInfo(String username, UserData userData) async {

    final db = await DatabaseService.database;
    final userId = await db.insert("AccountInfo", {
      "username": userData.username,
      "password": userData.password,
      "email": userData.email,
      "reviewed": userData.reviewed,
      "saved": userData.saved,
      "radius": userData.radius
    });

    final List<int> prices = [];
    final List<String> restrictions = [];
    final List<String> preferences = [];

    for (MapEntry<String, bool> entry in userData.dietaryRestrictions.entries) {
      if (!entry.value){
        continue;
      }
      if (entry.key == "\$") {
        prices.add(1);
      }
      else if (entry.key == "\$\$") {
        prices.add(2);
      }
      else if (entry.key == "\$\$\$") {
        prices.add(3);
      }
    }

    for (MapEntry<String, bool> entry in userData.foodPreferences.entries) {
      if (entry.value) {
        preferences.add(entry.key);
      }
    }

    for (MapEntry<String, bool> entry in userData.dietaryRestrictions.entries) {
      if (entry.value) {
        restrictions.add(entry.key);
      }
    }

    await _insertDietaryRestrictions(db, userId, restrictions);
    await _insertPreferences(db, userId, preferences);
    await _insertPrices(db, userId, prices);

    
  }

  Future<void> _deletePrices(Database db, int userId) async {
    
    db.delete("Price", where: "userId = ?", whereArgs: [userId]);

  }

  Future<void> _deletePreferences(Database db, int userId) async {
    
    db.delete("Preferences", where: "userId = ?", whereArgs: [userId]);

  }

  Future<void> _deleteDietaryRestrictions(Database db, int userId) async {
    
    db.delete("DietaryRestrictions", where: "userId = ?", whereArgs: [userId]);

  }

  Future<void> updateAccountInfo(AccountInfoData newData, String username) async {

    final db = await DatabaseService.database;
    final userId = await _getUserId(db, username);
    await db.update("AccountInfo", newData.toMap(), where: "userID = ?", whereArgs: [userId]);

  }

  Future<void> updatePrices(String username, List<int> prices) async {

    final db = await DatabaseService.database;
    final userId = await _getUserId(db, username);
    // Naive implementation for prototype
    await _deletePrices(db, userId);
    await _insertPrices(db, userId, prices);

  }

  Future<void> updatePreferences(String username, List<String> preferences) async {

    final db = await DatabaseService.database;
    final userId = await _getUserId(db, username);
    // Naive implementation for prototype
    await _deletePreferences(db, userId);
    await _insertPreferences(db, userId, preferences);

  }

  Future<void> updateDietaryRestrictions(String username, List<String> restrictions) async {

    final db = await DatabaseService.database;
    final userId = await _getUserId(db, username);
    // Naive implementation for prototype
    await _deleteDietaryRestrictions(db, userId);
    await _insertDietaryRestrictions(db, userId, restrictions);

  }

  Future<UserData?> getAccountInfo(String username, String password) async {

    final db = await DatabaseService.database;
    final userList = await db.query(
      "AccountInfo", 
      where: "username = ? AND password = ?", 
      whereArgs: [username, password]
    );
    if (userList.isEmpty) {
      return null;
    }

    final user = userList[0];
    final int userId = user["id"] as int;
    final preferences = await _getPreferences(db, userId);
    final prices = await _getPrices(db, userId);
    final restrictions = await _getDietaryRestrictions(db, userId);

    final userData = UserData(
      username: user["username"] as String, 
      password: user["password"] as String, 
      email: user["email"] as String, 
      foodPreferences: preferences, 
      dietaryRestrictions: restrictions, 
      pricePoints: prices, 
      reviewed: user["reviewed"] as int, 
      saved: user["saved"] as int, 
      radius: user["radius"] as double
    );


  }

  Future<Map<String, bool>> _getPrices(Database db, int userId) async {

    final Map<String, bool> prices = {};
    final priceList = await db.query("Price", where: "userId = ?", whereArgs: [userId]);
    for (Map<String, Object?> price in priceList) {
      final priceLevel = price["price"] as int;
      String key = "";
      if (priceLevel == 1) {
        key = "\$";
      }
      else if (priceLevel == 2) {
        key = "\$\$";
      }
      else if (priceLevel == 3) {
        key = "\$\$\$";
      }
      prices[key] = true;
    }
    for (String price in UserConstants.pricePoints) {
      if (!prices.containsKey(price)) {
        prices[price] = false;
      }
    }
    return prices;

  }

  Future<Map<String, bool>> _getPreferences(Database db, int userId) async {

    final Map<String, bool> preferences = {};
    final preferenceList = await db.query("Preferences", where: "userId = ?", whereArgs: [userId]);
    for (Map<String, Object?> preference in preferenceList) {
      final key = preference["preference"] as String;
      preferences[key] = true;
    }
    for (String preference in UserConstants.foodExperiences) {
      if (!preferences.containsKey(preference)) {
        preferences[preference] = false;
      }
    }
    return preferences;

  }

  Future<Map<String, bool>> _getDietaryRestrictions(Database db, int userId) async {

    final Map<String, bool> restrictions = {};
    final restrictionList = await db.query("DietaryRestrictions", where: "userId = ?", whereArgs: [userId]);
    for (Map<String, Object?> restriction in restrictionList) {
      final key = restriction["preference"] as String;
      restrictions[key] = true;
    }
    for (String restriction in UserConstants.dietaryRestrictions) {
      if (!restrictions.containsKey(restriction)) {
        restrictions[restriction] = false;
      }
    }
    return restrictions;

  }

  


}

class AccountInfoData {

  String username;
  String password;
  String email;
  int reviewed;
  int saved;
  double radius;

  AccountInfoData({
    required this.username,
    required this.password,
    required this.email,
    required this.reviewed,
    required this.saved, 
    required this.radius,
  });

  Map<String, dynamic> toMap() {

    final Map<String, dynamic> map = {
      "username": username,
      "password": password,
      "email": email,
      "reviewed": reviewed,
      "saved": saved,
      "radius": radius
    };
    return map;

  }

}