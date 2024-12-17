import 'package:flutter/cupertino.dart';
import 'package:indulge/restaurant/models/restaurant.dart';
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
    List<Restaurant> tempRestaurants = await service.getUnviewedRestaurants();

    //probably a better way to do this but doing this for now
    _restaurants = tempRestaurants.map(
      (restaurant) => Restaurant.fromMap(
        {
          'id': restaurant.id,
          'name' : restaurant.name,
          'distance': restaurant.distance,
          'type': restaurant.type,
          'imageUrl': restaurant.imageUrl,
          'restrictions' : restaurant.restrictions,
          'globalRating': restaurant.globalRating,
          'reviewed': restaurant.reviewed,
          'indulged': restaurant.indulged,
          'viewed' : restaurant.viewed
        }
      )
    ).toList();
    
    _isLoading = false;
    notifyListeners();
  }

  void setRestuarantIndulgedById(int id, int indulged) {
    service.setRestuarantIndulgedById(id, indulged);
    notifyListeners();
  }

  void updateRestaurant(Restaurant restaurant) {
    service.updateRestaurant(restaurant);
    notifyListeners();
  }

  void setRestuarantReviewedById(int id, int reviewed) {
    service.setRestuarantReviewedById(id, reviewed);
    notifyListeners();
  }

  void setRestuarantViewedById(int id, int viewed) {
    service.setRestuarantViewedById(id, viewed);
    notifyListeners();
  }

  void swipeLeft() {
    if (_currentIndex < _restaurants.length) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void swipeRight() {
    if (_currentIndex < _restaurants.length) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void skip() {
    if (_currentIndex < _restaurants.length) {
      _currentIndex++;
      notifyListeners();
    }
  }
}
