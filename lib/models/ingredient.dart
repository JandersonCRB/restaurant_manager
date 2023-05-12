class Ingredient {
  int? id;
  String? name;
  int? quantity;

  Ingredient({this.id, this.name, this.quantity});

  Ingredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity
    };
  }
}