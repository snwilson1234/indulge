import 'package:json_annotation/json_annotation.dart';
import 'package:indulge/lists/models/dummy_restaurant.dart';

part 'restaurant_list.g.dart';

@JsonSerializable(explicitToJson: true)
class RestaurantList {
  final String name;
  final List<DummyRestaurant> listItems;

  RestaurantList({required this.name, required this.listItems});

  factory RestaurantList.fromJson(Map<String, dynamic> json) => _$RestaurantListFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantListToJson(this);
}