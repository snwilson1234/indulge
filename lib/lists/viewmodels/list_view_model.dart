
import 'package:indulge/lists/models/dummy_restaurant.dart';
import 'package:indulge/lists/models/restaurant_list.dart';

class ListViewModel {
  final RestaurantList list;

  ListViewModel({required this.list});

  String get name {
    return list.name;
  }

  List<DummyRestaurant> get listItems {
    return list.listItems;
  }
}