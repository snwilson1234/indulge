import 'package:indulge/database/db_service.dart';
import 'package:indulge/lists/models/restaurant_list.dart';


class RestaurantListService {
  
  Future<int> insertRestaurantList(RestaurantList restaurantList) async {
    final db = await DatabaseService.database;
    return await db.insert('RestaurantList', restaurantList.toMap());
  }

  Future<List<RestaurantList>> getAllRestaurantLists() async {
    final db = await DatabaseService.database;
    // final List<Map<String, dynamic>> maps = await db.query('RestaurantList');

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT 
        rl.id AS id,
        rl.name,
        json_group_array(
            json_object(
                'id', dr.id,
                'name', dr.restaurantName,
                'listId', dr.listId
            )
        ) AS listItems
    FROM RestaurantList rl
    LEFT JOIN DummyRestaurant dr ON rl.id = dr.listId
    GROUP BY rl.id, rl.name;
    ''');

    print("maps: $maps");

    return List.generate(maps.length, (i) {
      return RestaurantList.fromMap(maps[i]);
    });
  }
//use this instead?
  Future<List<RestaurantList>> getRestaurantListsByRestaurantId(int restaurantListId) async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'RestaurantList',
      where: 'restaurantListId = ?',
      whereArgs: [restaurantListId],
    );

    return List.generate(maps.length, (i) {
      return RestaurantList.fromMap(maps[i]);
    });
  }

  Future<int> updateRestaurantList(RestaurantList restaurantList) async {
    final db = await DatabaseService.database;
    return await db.update(
      'RestaurantList',
      restaurantList.toMap(),
      where: 'id = ?',
      whereArgs: [restaurantList.id],
    );
  }

  Future<int> deleteRestaurantList(int id) async {
    final db = await DatabaseService.database;
    return await db.delete(
      'RestaurantList',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}