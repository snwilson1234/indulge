
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:indulge/lists/models/restaurant_list.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';

class ListsViewModel extends ChangeNotifier {
  List<ListViewModel> lists = <ListViewModel>[];

  Future<void> fetchListsJson(String? searchTerm) async {
    final response = await rootBundle.loadString('assets/lists.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> results = data['lists'];
    if (searchTerm != null) {
      final lowerCaseSearchTerm = searchTerm.toLowerCase();
      lists = results.where((item) {
        final list = RestaurantList.fromJson(item);
        return list.name.toLowerCase().contains(lowerCaseSearchTerm);
      }).map((item) {
        final list = RestaurantList.fromJson(item);
        return ListViewModel(list: list);
      }).toList();
    }
    else {
      lists = results.map((item) {
        final list = RestaurantList.fromJson(item);
        return ListViewModel(list: list);
      }).toList();
    }
    notifyListeners();
  }
}