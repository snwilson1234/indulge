
import 'package:indulge/reviews/models/review.dart';

class ReviewViewModel {
  final Review review;

  ReviewViewModel({required this.review});

  String get restaurantName {
    return review.restaurantName;
  }

  double get rating {
    return review.rating;
  }

  String get comment  {
    return review.comment;
  }
}