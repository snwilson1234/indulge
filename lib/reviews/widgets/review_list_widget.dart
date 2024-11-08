import 'package:flutter/cupertino.dart';
import 'package:indulge/common/list_separator.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/widgets/review_item_widget.dart';
import 'package:indulge/routing/routes.dart';

class ReviewListWidget extends StatelessWidget {
  final List<ReviewViewModel> reviews;

  const ReviewListWidget({super.key, required this.reviews});
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reviews.length,
      itemBuilder: (context, index) {

        final review = reviews[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              reviewDetailRoute, 
              arguments: review.restaurantName
            );
          },
          child: ReviewItemWidget(
            review: review
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const ListSeparator();
      },
    );
  }

}