import 'package:indulge/database/db_service.dart';
import 'package:indulge/lists/models/restaurant_list.dart';
import 'package:indulge/restaurant/models/restaurant.dart';


class RestaurantListService {

  Future<List<RestaurantList>> getAllRestaurantLists() async {
    final db = await DatabaseService.database;

    final List<Map<String, dynamic>> listMaps = await db.query('RestaurantList');
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
      restaurantsByList[listId]!.add(restaurant);
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

  Future<List<RestaurantList>> getListsBySearchKeyword(String keyword) async {
    final db = await DatabaseService.database;

    // Query to fetch RestaurantLists with names matching the keyword
    final List<Map<String, dynamic>> listMaps = await db.query(
      'RestaurantList',
      where: 'name LIKE ?',
      whereArgs: ['%$keyword%'],
    );

    // Query to get all the list helpers (associates lists with restaurants)
    final List<Map<String, dynamic>> listHelperMaps = await db.query('ListHelper', orderBy: 'listId ASC');

    // Map to hold the restaurants by listId
    Map<int, List<Map<String, dynamic>>> restaurantsByList = {};

    // Build the map of listId to restaurant entries
    for (var listHelperMap in listHelperMaps) {
      int listId = listHelperMap['listId'];
      int restaurantId = listHelperMap['restaurantId'];

      if (!restaurantsByList.containsKey(listId)) {
        restaurantsByList[listId] = [];
      }

      List<Map<String, dynamic>> restaurantL = await db.query('Restaurant', where: 'id = $restaurantId');
      if (restaurantL.isNotEmpty) {
        Map<String, dynamic> restaurant = restaurantL[0];
        restaurantsByList[listId]!.add(restaurant);
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


  Future<RestaurantList> getListByName(String listName) async {
    final db = await DatabaseService.database;
    final List<Map<String, dynamic>> listMap = await db.query(
      'RestaurantList', 
      where: 'name = ?',
      whereArgs: [listName]
    );
    final RestaurantList restaurantList = RestaurantList.fromMap(listMap[0]);
    return restaurantList;
  }

  Future<RestaurantList> getListById(int listId) async {
    final db = await DatabaseService.database;
    
    // get the list id, name
    final List<Map<String, dynamic>> listMap = await db.query(
      'RestaurantList', 
      where: 'id = ?',
      whereArgs: [listId]
    );
    
    // get restaurant ids for this list id stored in helper table 
    final List<Map<String, dynamic>> listItems = await db.query('ListHelper', where: 'listId = ?', whereArgs: [listId]);
    final List<int> restaurantIds = listItems.map<int>((item) {
      return item['restaurantId'] as int;
    }).toList();

    // use restaurant ids to get actual entries
    final List<Map<String, dynamic>> restaurantMaps = await db.query('Restaurant', where: 'id IN (${List.filled(restaurantIds.length, '?').join(', ')})', whereArgs: restaurantIds);

    // make a restaurant list from this map. sqflite always returns list but we know there is always only one entry due to primary key.
    RestaurantList restaurantList = RestaurantList.fromMap(listMap[0]);
    
    // set the list's listItems to the actual restaurant maps and return final RestaurantList
    restaurantList.listItems = restaurantMaps.map<Restaurant>((map) {
      return Restaurant.fromMap(map);
    }).toList();
    return restaurantList;
  }

  Future<void> addRestaurantToList(int listId, int restaurantId) async {
    final db = await DatabaseService.database;
    await db.insert('ListHelper', {
      'listId': listId,
      'restaurantId': restaurantId
    });
  }

}