import 'package:indulge/restaurant/models/restaurant.dart';

// RestaurantList Model, the sqflite way.
// https://pub.dev/packages/sqflite

class RestaurantList {
  int? id;
  String? name;
  List<Restaurant>? listItems;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'name': name,
      'listItems': listItems,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  RestaurantList();

  RestaurantList.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    if (map['listItems'] == null) {
      listItems = [];
    }
    else {
      listItems = map['listItems'];
    }
  }
}
