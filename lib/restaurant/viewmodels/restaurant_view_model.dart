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

  void fetchRestaurants() {
    service.getAllRestaurants();
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
