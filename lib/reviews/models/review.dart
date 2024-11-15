
class Review {
  int? id;
  int? restaurantId;
  double? rating;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'restaurantId': restaurantId,
      'rating': rating
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
  }
}
