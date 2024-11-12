// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DummyRestaurant _$DummyRestaurantFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name'],
  );
  return DummyRestaurant(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$DummyRestaurantToJson(DummyRestaurant instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
