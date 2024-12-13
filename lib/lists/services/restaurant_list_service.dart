import 'package:indulge/database/db_service.dart';
import 'package:indulge/lists/models/restaurant_list.dart';
import 'package:indulge/restaurant/models/restaurant.dart';
import 'dart:convert';


class RestaurantListService {

  Future<List<RestaurantList>> getAllRestaurantLists() async {
    final db = await DatabaseService.database;

    final List<Map<String, dynamic>> listMaps = await db.query('RestaurantList');

    final List<Map<String, dynamic>> restaurantMaps = await db.query('Restaurant');

    final List<Map<String, dynamic>> listHelperMaps = await db.query('ListHelper', orderBy: 'listId ASC');

    Map<int, List<Map<String, dynamic>>> restaurantsByList = {};

    for (var listHelperMap in listHelperMaps) {
      int listId = listHelperMap['listId'];
      int restaurantId = listHelperMap['restaurantId'];
      if (!restaurantsByList.containsKey(listId)) {
        restaurantsByList[listId] = [];
      }
      List<Map<String, dynamic>> restaurantL = await db.query('Restaurant', where: 'id = $restaurantId');
      Map<String, dynamic> restaurant = restaurantL[0];
      print("restaurant map: $restaurant");
      restaurantsByList[listId]!.add(restaurant);
    }

    // for (var listMap in listMaps) {
    //   int listId = listMap['id'];

    //   if (!restaurantsByList.containsKey(listId)) {
    //     restaurantsByList[listId] = [];
    //   }

    //   for (var restaurant in restaurantMaps) {
    //     int restListId = restaurant['listId'] ?? -1;
    //     if (restListId == -1) {
    //       continue;
    //     }
    //     else {
    //       if (listId == restListId) {
    //         restaurantsByList[listId]!.add(restaurant);
    //       }
    //     }
    //   }
    // }

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

  Future<RestaurantList> getListById(int listId) async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> listMap = await db.query('RestaurantList', where: 'id = $listId');
    final RestaurantList restaurantList = RestaurantList.fromMap(listMap[0]);
    return restaurantList;
  }

  Future<RestaurantList> getListByName(String listName) async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> listMap = await db.query('RestaurantList', where: 'name = "$listName"');
    final RestaurantList restaurantList = RestaurantList.fromMap(listMap[0]);
    return restaurantList;
  }

  Future<void> addRestaurantToList(int listId, int restaurantId) async {
    final db = await DatabaseService.database;
    await db.insert('ListHelper', {
      'listId': listId,
      'restaurantId': restaurantId
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