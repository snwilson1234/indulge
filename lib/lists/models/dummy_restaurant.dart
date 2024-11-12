import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'dummy_restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class DummyRestaurant {
  DummyRestaurant({required this.name, required this.reviewed});
  
  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true)
  final bool reviewed;

  factory DummyRestaurant.fromJson(Map<String, dynamic> json) => _$DummyRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$DummyRestaurantToJson(this);
}