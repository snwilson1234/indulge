
import 'package:flutter/foundation.dart';
import 'package:indulge/reviews/models/review.dart';
import 'package:indulge/reviews/services/review_service.dart';

class ReviewViewModel extends ChangeNotifier {
  Review? review;
  ReviewService reviewService = ReviewService();

  ReviewViewModel({this.review});

  int? get id {
    return review?.id;
  }

  int? get restaurantId {
    return review?.restaurantId;
  }

  String? get restaurantName {
    return review?.restaurantName;
  }

  double? get rating {
    return review?.rating;
  }

  String? get comment  {
    return review?.comment;
  }

  Future<void> fetchReviewById(int reviewId) async {
    Review tempReview = await reviewService.getReviewById(reviewId);
    review = tempReview;
  }
}