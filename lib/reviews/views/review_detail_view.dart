import 'package:flutter/cupertino.dart';
import 'package:indulge/common/static_star_widget.dart';
import 'package:indulge/restaurant/viewmodels/restaurant_view_model.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:provider/provider.dart';

class ReviewDetailView extends StatefulWidget {
  const ReviewDetailView({super.key});

  @override
  _ReviewDetailViewState createState() => _ReviewDetailViewState();
}

class _ReviewDetailViewState extends State<ReviewDetailView> {

  final TextEditingController _reviewController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReviewViewModel>(context, listen: false);
    final id = vm.id;
    final restaurantId = vm.restaurantId;
    final restaurantName = vm.restaurantName; 
    final rating = vm.rating; 
    final comment = vm.comment;
    _reviewController.text = comment!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Review for $restaurantName"),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              alignment: Alignment.center,
              child: CupertinoButton(
                color: CupertinoColors.systemRed,
                onPressed: () {
                  // TODO: add a popup ("are you sure you want to delete this review?")
                  final reviewId = id;
                  // delete the review
                  Provider.of<ReviewsViewModel>(context, listen: false).deleteReview(reviewId!);
                  
                  // update the restaurant so it is no longer reviewed
                  Provider.of<RestaurantViewModel>(context, listen: false).setRestuarantReviewedById(restaurantId!, 0);
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
            )
          ],
        ),
      )
    );
  }
  
}