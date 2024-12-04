import 'package:indulge/database/db_service.dart';
import 'package:indulge/lists/models/restaurant_list.dart';


class RestaurantListService {

  Future<List<RestaurantList>> getAllRestaurantLists() async {
    final db = await DatabaseService.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT 
        rl.id AS id,
        rl.name,
        json_group_array(
            json_object(
                'id', r.id,
                'name', r.name,
                'distance', r.distance,
                'type', r.type,
                'imageUrl', r.imageUrl,
                'globalRating', r.globalRating,
                'listId', r.listId,
                'reviewed', r.reviewed
            )
        ) AS listItems
    FROM RestaurantList rl
    LEFT JOIN Restaurant r ON rl.id = r.listId
    GROUP BY rl.id, rl.name;
    ''');

    print("maps: $maps");

    return List.generate(maps.length, (i) {
      return RestaurantList.fromMap(maps[i]);
    });
  }




  // Not currently used
  // Future<int> updateRestaurantList(RestaurantList restaurantList) async {
  //   final db = await DatabaseService.database;
  //   return await db.update(
  //     'RestaurantList',
  //     restaurantList.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [restaurantList.id],
  //   );
  // }

  // Future<int> deleteRestaurantList(int id) async {
  //   final db = await DatabaseService.database;
  //   return await db.delete(
  //     'RestaurantList',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future<List<RestaurantList>> getRestaurantListById(int id) async {
  //   final db = await DatabaseService.database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'RestaurantList',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );

  //   return List.generate(maps.length, (i) {
  //     return RestaurantList.fromMap(maps[i]);
  //   });
  // }

  // Future<int> insertRestaurantList(RestaurantList restaurantList) async {
  //   final db = await DatabaseService.database;
  //   return await db.insert('RestaurantList', restaurantList.toMap());
  // }
}