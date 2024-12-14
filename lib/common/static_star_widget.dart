import 'package:flutter/cupertino.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:indulge/common/theme.dart';

// Static star widget for displaying already submitted ratings.
class StaticStarWidget extends StatelessWidget {
  final double rating;
  const StaticStarWidget({super.key, required this.rating});
  
  @override
  Widget build(BuildContext context) {
    return StarRating(
      color: indulgePrimary,
      rating: rating,
      allowHalfRating: false,
    );
  }
}
