
class DummyRestaurant {
  int? id;
  String? name;
  bool? reviewed;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'name': name,
      'reviewed': reviewed,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  DummyRestaurant();

  DummyRestaurant.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    reviewed = map['reviewed'];
  }
}

// @JsonSerializable(explicitToJson: true)
// class DummyRestaurant {
//   DummyRestaurant({required this.name, required this.reviewed});
  
//   @JsonKey(required: true)
//   final String name;

//   @JsonKey(required: true)
//   final bool reviewed;

//   factory DummyRestaurant.fromJson(Map<String, dynamic> json) => _$DummyRestaurantFromJson(json);

//   Map<String, dynamic> toJson() => _$DummyRestaurantToJson(this);
// }