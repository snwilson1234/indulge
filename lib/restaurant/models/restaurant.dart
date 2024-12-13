class Restaurant {
  final int? id;
  final String name;
  final String distance;
  final String type;
  final String imageUrl;
  final double globalRating;
  int? reviewed;
  int? indulged;
  int? viewed;

  Restaurant({
    this.id,
    required this.name,
    required this.distance,
    required this.type,
    required this.imageUrl,
    required this.globalRating,
    this.reviewed,
    this.indulged,
    this.viewed
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'distance': distance,
      'type': type,
      'imageUrl': imageUrl,
      'globalRating': globalRating,
      'reviewed': reviewed,
      'indulged': indulged,
      'viewed' : viewed
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] as int?,
      name: map['name'] as String,
      distance: map['distance'] as String,
      type: map['type'] as String,
      imageUrl: map['imageUrl'] as String,
      globalRating: map['globalRating'] as double,
      reviewed: map['reviewed'] as int,
      indulged: map['indulged'] as int,
      viewed: map['viewed'] as int
    );
  }
}
