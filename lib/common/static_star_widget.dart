import 'package:flutter/cupertino.dart';
import 'package:flutter_rating/flutter_rating.dart';

class StaticStarWidget extends StatelessWidget {
  final double rating;
  const StaticStarWidget({super.key, required this.rating});
  
  @override
  Widget build(BuildContext context) {
    return StarRating(
      color: CupertinoColors.black,
      rating: rating,
      allowHalfRating: false,
    );
  }
}
