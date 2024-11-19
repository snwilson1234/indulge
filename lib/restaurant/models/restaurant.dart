class Restaurant {
  final int? id;
  final String name;
  final String distance;
  final String type;
  final String imageUrl;
  final double rating;

  Restaurant({
    this.id,
    required this.name,
    required this.distance,
    required this.type,
    required this.imageUrl,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'distance': distance,
      'type': type,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] as int?,
      name: map['name'] as String,
      distance: map['distance'] as String,
      type: map['type'] as String,
      imageUrl: map['imageUrl'] as String,
      rating: map['rating'] as double,
    );
  }
}
