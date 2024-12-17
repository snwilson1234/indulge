
import 'package:flutter/cupertino.dart';
import 'package:indulge/common/static_star_widget.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';

class ReviewItemWidget extends StatelessWidget {
  
  final ReviewViewModel review;
  
  const ReviewItemWidget({
    required this.review,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.black,
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 10.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${review.restaurantName}",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white,
                ),
              ),
              IconTheme(
                data: const IconThemeData(
                  color: CupertinoColors.white,
                  size: 16.0
                ), 
                child: StaticStarWidget(
                  rating: review.rating!
                )
              )
            ],
          ),
          const IconTheme(
            data: IconThemeData(
              color: CupertinoColors.black
            ), 
            child: Icon(
              CupertinoIcons.right_chevron
            )
          )
        ],
      )
    );
  }

}