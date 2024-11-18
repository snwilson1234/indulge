
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

  void updateRestaurant(DummyRestaurant restaurant) {
    service.updateDummyRestaurant(restaurant);
  }

  void setRestuarantReviewedById(int id, int reviewed) {
    service.setRestuarantReviewedById(id, reviewed);
  }


}