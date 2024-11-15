
import 'package:indulge/reviews/models/review.dart';

class ReviewViewModel {
  final Review review;

  ReviewViewModel({required this.review});

  int? get restaurantId {
    return review.restaurantId;
  }

  double? get rating {
    return review.rating;
  }

  // String get comment  {
  //   return review.comment;
  // }
}