
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/widgets/review_item_widget.dart';

class ReviewListWidget extends StatelessWidget {
  final List<ReviewViewModel> reviews;

  const ReviewListWidget({super.key, required this.reviews});
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reviews.length,
      itemBuilder: (context, index) {

        final review = reviews[index];

        return ReviewItemWidget(
          review: review
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

}