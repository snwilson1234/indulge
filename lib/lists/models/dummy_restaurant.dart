class DummyRestaurant {
  final String name;

  DummyRestaurant({required this.name});

  factory DummyRestaurant.fromJson(Map<String, dynamic> json) {
    return DummyRestaurant(
      name: json["name"],
    );
  }
}