import 'package:flutter/cupertino.dart';
import 'package:flutter_rating/flutter_rating.dart';

class StarWidget extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingChanged;
  const StarWidget({super.key, required this.initialRating, required this.onRatingChanged});
  
  @override
  State<StatefulWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return StarRating(
      color: CupertinoColors.black,
            rating: _rating,
            allowHalfRating: false,
            onRatingChanged: (rating) {
              setState(() {
                _rating = rating;
              });
              print("Rating changed to $_rating");
              widget.onRatingChanged(_rating);
            },
          );
  }
  
}