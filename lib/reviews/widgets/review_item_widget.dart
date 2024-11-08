
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/common/star_widget.dart';
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
      color: CupertinoColors.white,
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
                review.restaurantName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
              ),
              const IconTheme(
                data: IconThemeData(
                  color: CupertinoColors.black,
                  size: 16.0
                ), 
                child: StarWidget(
                  value: 3
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