class Review {
  final String restaurantName;
  final double rating;
  final String comment;

  Review({required this.restaurantName, required this.rating, required this.comment});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      restaurantName: json["restaurantName"],
      rating: double.parse(json["rating"]),
      comment: json["comment"],
    );
  }
}