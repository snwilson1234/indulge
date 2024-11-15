import 'dart:convert';

import 'package:indulge/lists/models/dummy_restaurant.dart';


class RestaurantList {
  int? id;
  String? name;
  List<DummyRestaurant>? listItems;

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
    print("list items: ${map['listItems']}");
    List<dynamic> decodedList = jsonDecode(map['listItems']);
    listItems = decodedList
                  .map((item) => DummyRestaurant.fromMap(item as Map<String, dynamic>))
                  .toList();
  }
}
