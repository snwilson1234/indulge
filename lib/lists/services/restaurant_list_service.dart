import 'package:indulge/database/db_service.dart';
import 'package:indulge/lists/models/restaurant_list.dart';
import 'package:indulge/restaurant/models/restaurant.dart';
import 'dart:convert';


class RestaurantListService {

  Future<List<RestaurantList>> getAllRestaurantLists() async {
    final db = await DatabaseService.database;

    final List<Map<String, dynamic>> listMaps = await db.query('RestaurantList');

    final List<Map<String, dynamic>> restaurantMaps = await db.query('Restaurant');

    Map<int, List<Map<String, dynamic>>> restaurantsByList = {};

    for (var listMap in listMaps) {
      int listId = listMap['id'];

      if (!restaurantsByList.containsKey(listId)) {
        restaurantsByList[listId] = [];
      }

      for (var restaurant in restaurantMaps) {
        int restListId = restaurant['listId'] ?? -1;
        if (restListId == -1) {
          continue;
        }
        else {
          if (listId == restListId) {
            restaurantsByList[listId]!.add(restaurant);
          }
        }
      }
    }

    return listMaps.map((listMap) {
      int listId = listMap['id'];
      List<Map<String, dynamic>> listItems = restaurantsByList[listId] ?? [];

      List<Restaurant> restaurants = listItems.map((restaurantMap) {
        return Restaurant.fromMap(restaurantMap);
      }).toList();


      return RestaurantList.fromMap({
        'id': listMap['id'],
        'name': listMap['name'],
        'listItems': restaurants,
      });
    }).toList();

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