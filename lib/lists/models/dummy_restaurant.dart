
class DummyRestaurant {
  int? id;
  String? name;
  int? listId;
  int? reviewed;// 0 = false, 1 = true. sqlite doesnt support bool

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'name': name,
      'listId': listId,
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
    listId = map['listId'];
    reviewed = map['reviewed'];
  }
}
