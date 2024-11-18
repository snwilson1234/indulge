
class Review {
  int? id;
  int? restaurantId;
  String? restaurantName;
  double rating = 0.0; //just a temp to appease compiler
  String? comment;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'rating': rating,
      'comment': comment
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Review();

  Review.withParams({
    this.id,
    required this.restaurantId,
    this.restaurantName,
    required this.rating,
    this.comment,
  });

  Review.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    restaurantId = map['restaurantId'];
    restaurantName = map['restaurantName'];
    rating = map['rating'];
    comment = map['comment'];
  }
}
