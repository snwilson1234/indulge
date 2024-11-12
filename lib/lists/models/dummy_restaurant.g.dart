// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DummyRestaurant _$DummyRestaurantFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'reviewed'],
  );
  return DummyRestaurant(
    name: json['name'] as String,
    reviewed: json['reviewed'] as bool,
  );
}

Map<String, dynamic> _$DummyRestaurantToJson(DummyRestaurant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'reviewed': instance.reviewed,
    };
