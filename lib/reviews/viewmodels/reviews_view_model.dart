import 'package:flutter/cupertino.dart';
import 'package:indulge/reviews/models/review.dart';
import 'package:indulge/reviews/services/review_service.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';


class ReviewsViewModel extends ChangeNotifier {
  List<ReviewViewModel> reviews = <ReviewViewModel>[];
  ReviewService reviewService = ReviewService();
  
  Future<void> fetchReviews() async {
    List<Review> tempReviews = await reviewService.getAllReviews();
    reviews = tempReviews.map((review) => ReviewViewModel(review: review)).toList();
    notifyListeners();
  }

  void submitReview(ReviewViewModel review) {
    
  }
}