import 'package:flutter/cupertino.dart';
import 'package:indulge/common/static_star_widget.dart';
import 'package:indulge/lists/viewmodels/dummy_restaurant_view_model.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:provider/provider.dart';


class ReviewDetailView extends StatelessWidget {
  final ReviewViewModel reviewViewModel;

  final TextEditingController _reviewController = TextEditingController();

  ReviewDetailView({super.key, required this.reviewViewModel});
  
  @override
  Widget build(BuildContext context) {
    final restaurantName = reviewViewModel.restaurantName; 
    final rating = reviewViewModel.rating; 
    final comment = reviewViewModel.comment;
    _reviewController.text = comment!;
    print("COMMENT: $comment");   
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Review for $restaurantName"),
        backgroundColor: CupertinoColors.white,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        color: CupertinoColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Your rating:",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20.0),
            IconTheme(
              data: const IconThemeData(
                color: CupertinoColors.black,
                size: 40.0
              ), 
              child: 
              StaticStarWidget(rating: rating!)
            ),
            const SizedBox(height: 30.0),
            const Text(
              "Your Comment:",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              comment,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal
              ),
            ),
            // TODO: implement editing submitted reviews
            // ReviewEditorWidget(
            //   initialComment: comment!,
            //   controller: _reviewController,
            // ),
            const SizedBox(height: 50.0),
            Container(
              alignment: Alignment.center,
              child: CupertinoButton(
                color: CupertinoColors.systemRed,
                onPressed: () {
                  print("pressed delete!");
                  // TODO: add a popup ("are you sure you want to delete this review?")
                  final reviewId = reviewViewModel.id;
                  // delete the review
                  Provider.of<ReviewsViewModel>(context, listen: false).deleteReview(reviewId!);
                  
                  // update the restaurant so it is no longer reviewed
                  Provider.of<DummyRestaurantViewModel>(context, listen: false).setRestuarantReviewedById(reviewViewModel.restaurantId!, 0);
                  // fetch the updated list of reviews
                  
                  Provider.of<ReviewsViewModel>(context, listen: false).fetchReviews();
                  // go back to reviews page
                  
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // TODO: implement ediitng submitted reviews
              // child: Column(
              //   children: <Widget>[
              //     CupertinoButton(
              //       color: CupertinoColors.black,
              //       onPressed: () {
              //         print("pressed submit!");
              //       },
              //       child: const Text(
              //         "Submit",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(height: 10.0),
              //     CupertinoButton(
              //       color: CupertinoColors.inactiveGray,
              //       onPressed: () {
              //         print("pressed cancel!");
              //       },
              //       child: const Text(
              //         "Cancel",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            )
          ],
        ),
      )
    );
  }
  
}