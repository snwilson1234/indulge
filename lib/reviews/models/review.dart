
class Review {
  int? id;
  int? restaurantId;
  double rating = 0.0; //just a temp to appease compiler
  String? comment;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'restaurantId': restaurantId,
      'rating': rating,
      'comment': comment
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Review();

  Review.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    restaurantId = map['restaurantId'];
    rating = map['rating'];
    comment = map['comment'];
  }
}
