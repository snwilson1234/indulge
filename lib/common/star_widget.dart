import 'package:flutter/cupertino.dart';
import 'package:flutter_rating/flutter_rating.dart';

class StarWidget extends StatefulWidget {
  final int value;
  const StarWidget({super.key, this.value = 0});
  
  @override
  State<StatefulWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  double rating = 2;
  @override
  Widget build(BuildContext context) {
    return StarRating(
      color: CupertinoColors.black,
            rating: rating,
            allowHalfRating: false,
            onRatingChanged: (rating) => setState(() => this.rating = rating),
          );
  }
  
}