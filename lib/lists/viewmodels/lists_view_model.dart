
import 'package:flutter/cupertino.dart';
import 'package:indulge/lists/models/restaurant_list.dart';
import 'package:indulge/lists/services/restaurant_list_service.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';

class ListsViewModel extends ChangeNotifier {
  List<ListViewModel> lists = <ListViewModel>[];
  RestaurantListService listService = RestaurantListService();

  Future<RestaurantList> getListById(int listId) async {
    return listService.getListById(listId);
  }

  Future<RestaurantList> getListByName(String name) async {
    return listService.getListByName(name);
  }

  Future<void> fetchLists() async {
    List<RestaurantList> tempLists = await listService.getAllRestaurantLists();
    lists = tempLists.map((list) => ListViewModel(list: list)).toList();
    notifyListeners();
  }

  Future<void> addRestaurantToList(int listId, int restaurantId) async {
    listService.addRestaurantToList(listId, restaurantId);
    notifyListeners();
  }

  bool shouldShowIndulgedButton(String listName) {
    return listName != 'Been There';
  }

}