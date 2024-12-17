import 'package:flutter/cupertino.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:indulge/common/theme.dart';

// Dynamic star widget for rating restaurants in Reviews.
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
      color: indulgePrimary,
      rating: _rating,
      allowHalfRating: false,
      onRatingChanged: (rating) {
        setState(() {
          _rating = rating;
        });
        widget.onRatingChanged(_rating);
      },
    );
  }
  
}