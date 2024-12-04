import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart'; 
import 'dart:convert'; 
import 'package:indulge/restaurant/models/restaurant.dart';
import 'package:indulge/database/db_service.dart';
import 'package:indulge/restaurant/services/restaurant_service.dart';

class RestaurantViewModel extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  List<Restaurant> get restaurants => _restaurants;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;

  RestaurantService service = RestaurantService();

  void fetchRestaurants() async {
    _isLoading = true;
    List<Restaurant> tempRestaurants = await service.getAllRestaurants();
    //probably a better way to do this but doing this for now
    _restaurants = tempRestaurants.map(
      (restaurant) => Restaurant.fromMap(
        {
          'id': restaurant.id,
          'name' : restaurant.name,
          'distance': restaurant.distance,
          'type': restaurant.type,
          'imageUrl': restaurant.imageUrl,
          'globalRating': restaurant.globalRating,
          'listId': restaurant.listId,
          'reviewed': restaurant.reviewed
        }
      )
    ).toList();
    _isLoading = false;
    notifyListeners();
  }

  void updateRestaurant(Restaurant restaurant) {
    service.updateRestaurant(restaurant);
  }

  void setRestuarantReviewedById(int id, int reviewed) {
    service.setRestuarantReviewedById(id, reviewed);
  }



  // Future<void> fetchRestaurantsFromJson() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     final String response = await rootBundle.loadString('assets/dummy_restaurants.json');
  //     final List<dynamic> data = json.decode(response);
  //     _restaurants = data.map((json) => Restaurant.fromMap(json)).toList();
  //   } catch (e) {
  //     print("Error loading JSON data: $e");
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  void swipeLeft() {
    if (_currentIndex < _restaurants.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void swipeRight() {
    if (_currentIndex < _restaurants.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void skip() {
    if (_currentIndex < _restaurants.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }
}
