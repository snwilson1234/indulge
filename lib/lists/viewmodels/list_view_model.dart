
import 'package:indulge/lists/models/restaurant_list.dart';
import 'package:indulge/restaurant/models/restaurant.dart';

class ListViewModel {
  final RestaurantList list;

  ListViewModel({required this.list});

  int? get id {
    return list.id;
  }

  String? get name {
    return list.name;
  }

  List<Restaurant>? get listItems {
    return list.listItems;
  }
}