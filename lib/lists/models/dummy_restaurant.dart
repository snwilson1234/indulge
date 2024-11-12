import 'package:json_annotation/json_annotation.dart';

part 'dummy_restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class DummyRestaurant {
  DummyRestaurant({required this.name});
  
  @JsonKey(required: true)
  final String name;

  factory DummyRestaurant.fromJson(Map<String, dynamic> json) => _$DummyRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$DummyRestaurantToJson(this);
}