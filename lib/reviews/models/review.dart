import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  Review({required this.restaurantName, required this.rating, required this.comment});

  @JsonKey(required: true)
  final String restaurantName;

  @JsonKey(defaultValue: 0.0)
  final double rating;

  @JsonKey(defaultValue: "")
  final String comment;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}