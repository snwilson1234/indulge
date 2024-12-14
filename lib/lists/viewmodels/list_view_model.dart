
import 'package:flutter/foundation.dart';
import 'package:indulge/lists/models/restaurant_list.dart';
import 'package:indulge/lists/services/restaurant_list_service.dart';
import 'package:indulge/restaurant/models/restaurant.dart';

class ListViewModel extends ChangeNotifier{
  RestaurantList? list;
  RestaurantListService listService = RestaurantListService();

  ListViewModel({this.list});

  int? get id {
    return list?.id;
  }

  String? get name {
    return list?.name;
  }

  List<Restaurant>? get listItems {
    if (list!.listItems == null) {
      return [];
    }
    return list?.listItems;
  }

  Future<void> getListByName(String name) async {
    list = await listService.getListByName(name);
    notifyListeners();
  }

  Future<void> getListById(int listId) async {
    list = await listService.getListById(listId);
  }

  bool shouldShowIndulgedButton() {
    return list?.name != 'Been There';
  }
}