
import 'package:flutter/foundation.dart';
import 'package:indulge/lists/models/dummy_restaurant.dart';
import 'package:indulge/lists/services/dummy_restaurant_service.dart';

class DummyRestaurantViewModel extends ChangeNotifier {
  // DummyRestaurant restaurant;
  // // int? id;
  // // String? restaurantName;
  // // int? listId;
  // // int? restaurantNameed;

  DummyRestaurantService service = DummyRestaurantService();

  // // DummyRestaurantViewModel({required this.restaurant});

  // int? get id {
  //   return restaurant.id;
  // }

  // String? get restaurantName {
  //   return restaurant.restaurantName;
  // }

  // int? get listId {
  //   return restaurant.listId;
  // }

  // int? get reviewed {
  //   return restaurant.reviewed;
  // }

  void updateRestaurant(DummyRestaurant restaurant) {
    service.updateDummyRestaurant(restaurant);
  }


}