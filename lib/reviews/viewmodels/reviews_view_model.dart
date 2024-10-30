import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:indulge/reviews/models/review.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';


class ReviewsViewModel extends ChangeNotifier {
  List<ReviewViewModel> reviews = <ReviewViewModel>[];

  Future<void> fetchReviewsJson(String? searchTerm) async {
    final response = await rootBundle.loadString('assets/reviews.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> results = data['reviews'];
    if (searchTerm != null) {
      final lowerCaseSearchTerm = searchTerm.toLowerCase();
      reviews = results.where((item) {
        final review = Review.fromJson(item);
        return review.restaurantName.toLowerCase().contains(lowerCaseSearchTerm);
      }).map((item) {
        final review = Review.fromJson(item);
        return ReviewViewModel(review: review);
      }).toList();
    }
    else {
      reviews = results.map((item) {
        final review = Review.fromJson(item);
        return ReviewViewModel(review: review);
      }).toList();
    }
    notifyListeners();
  }
}