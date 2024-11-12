// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantList _$RestaurantListFromJson(Map<String, dynamic> json) =>
    RestaurantList(
      name: json['name'] as String,
      listItems: (json['listItems'] as List<dynamic>)
          .map((e) => DummyRestaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantListToJson(RestaurantList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'listItems': instance.listItems.map((e) => e.toJson()).toList(),
    };
