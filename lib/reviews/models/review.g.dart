// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['restaurantName'],
  );
  return Review(
    restaurantName: json['restaurantName'] as String,
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    comment: json['comment'] as String? ?? '',
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'restaurantName': instance.restaurantName,
      'rating': instance.rating,
      'comment': instance.comment,
    };
