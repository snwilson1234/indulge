import 'package:flutter/cupertino.dart';
import 'package:flutter_rating/flutter_rating.dart';

class StarWidget extends StatefulWidget {
  final int value;
  const StarWidget({super.key, this.value = 0})
      : assert(value != null);
  
  @override
  State<StatefulWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  double rating = 2.0;
  @override
  Widget build(BuildContext context) {
    return StarRating(
      color: CupertinoColors.black,
            rating: rating,
            allowHalfRating: false,
            onRatingChanged: (rating) {
              setState(() => this.rating = rating);
              print("rating changed to $rating");
            }
            // (rating) => setState(() => this.rating = rating),
          );
  }
  
}