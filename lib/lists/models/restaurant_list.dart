import 'package:indulge/lists/models/dummy_restaurant.dart';


class RestaurantList {
  final String name;
  // temporary dummy restaurant that just has a name
  final List<DummyRestaurant> listItems;


  RestaurantList({required this.name, required this.listItems});

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    return RestaurantList(
      name: json["name"],
      listItems: (json["listItems"] as List)
          .map((item) => DummyRestaurant.fromJson(item))
          .toList(),
    );
  }
}