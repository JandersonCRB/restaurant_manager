class Dish {
  int? id;
  String? name;
  List<int>? ingredientIds;

  Dish({this.id, this.name, this.ingredientIds});

  Dish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ingredientIds = json['igredientIds'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredientIds': ingredientIds
    };
  }
}