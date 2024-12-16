import 'package:indulge/database/db_service.dart';
import 'package:indulge/restaurant/models/restaurant.dart';
import 'package:indulge/user/services/account_info_service.dart';

class RestaurantService {

  Future<List<Restaurant>> getAllRestaurants() async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('Restaurant');

    return List.generate(maps.length, (i) {
      return Restaurant.fromMap(maps[i]);
    });
  }

   Future<List<Restaurant>> getUnviewedRestaurants() async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Restaurant', 
      where: 'viewed = ?',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return Restaurant.fromMap(maps[i]);
    });
  }

  Future<int> updateRestaurant(Restaurant restaurant) async {
    final db = await DatabaseService.database;
    return await db.update(
      'Restaurant',
      restaurant.toMap(),
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  void setRestuarantReviewedById(int id, int reviewed) async {
    final db = await DatabaseService.database;
    if (reviewed == 0) {
      await db.rawUpdate('''
        UPDATE Restaurant SET reviewed=0 where id=${id};
      ''');
    } 
    else {
      await db.rawUpdate('''
        UPDATE Restaurant SET reviewed=1 where id=${id};
      ''');
    }
  }

   void setRestuarantViewedById(int id, int viewed) async {
    final db = await DatabaseService.database;
    if (viewed == 0) {
      await db.rawUpdate('''
        UPDATE Restaurant SET viewed=0 where id=${id};
      ''');
    } 
    else {
      await db.rawUpdate('''
        UPDATE Restaurant SET viewed=1 where id=${id};
      ''');
    }
  }

  void setRestuarantIndulgedById(int id, int indulged) async {
    final db = await DatabaseService.database;
    if (indulged == 0) {
      await db.rawUpdate('''
        UPDATE Restaurant SET indulged=0 where id=${id};
      ''');
    } 
    else {
      await db.rawUpdate('''
        UPDATE Restaurant SET indulged=1 where id=${id};
      ''');
    }
  }
}