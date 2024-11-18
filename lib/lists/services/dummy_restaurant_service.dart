import 'package:indulge/database/db_service.dart';
import 'package:indulge/lists/models/dummy_restaurant.dart';


class DummyRestaurantService {
  
  Future<int> insertDummyRestaurant(DummyRestaurant restaurant) async {
    final db = await DatabaseService.database;
    return await db.insert('DummyRestaurant', restaurant.toMap());
  }

  Future<List<DummyRestaurant>> getAllDummyRestaurants() async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('DummyRestaurant');

    return List.generate(maps.length, (i) {
      return DummyRestaurant.fromMap(maps[i]);
    });
  }

  Future<List<DummyRestaurant>> getDummyRestaurantById(int id) async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'DummyRestaurant',
      where: 'restaurantId = ?',
      whereArgs: [id],
    );

    return List.generate(maps.length, (i) {
      return DummyRestaurant.fromMap(maps[i]);
    });
  }

  Future<int> updateDummyRestaurant(DummyRestaurant restaurant) async {
    final db = await DatabaseService.database;
    return await db.update(
      'DummyRestaurant',
      restaurant.toMap(),
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  void setRestuarantReviewedById(int id, int reviewed) async {
    final db = await DatabaseService.database;
    if (reviewed == 0) {
      await db.rawUpdate('''
        UPDATE DummyRestaurant SET reviewed=0 where id=${id};
      ''');
    } 
    else {
      await db.rawUpdate('''
        UPDATE DummyRestaurant SET reviewed=1 where id=${id};
      ''');
    }
  }


  Future<int> deleteDummyRestaurant(int id) async {
    final db = await DatabaseService.database;
    return await db.delete(
      'DummyRestaurant',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}