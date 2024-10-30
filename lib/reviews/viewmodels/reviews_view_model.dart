

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:indulge/reviews/models/review.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/widgets/review_item_widget.dart';

class ReviewsViewModel extends ChangeNotifier {
  List<ReviewViewModel> reviews = <ReviewViewModel>[];

  Future<void> fetchReviewsJson() async {
    final response = await rootBundle.loadString('assets/reviews.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> results = data['reviews'];
    reviews = results.map((item) {
        final review = Review.fromJson(item);
        return ReviewViewModel(review: review);
      }).toList();
    notifyListeners();
  }
}