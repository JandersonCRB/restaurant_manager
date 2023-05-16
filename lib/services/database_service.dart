import 'dart:convert';
import 'dart:io';

import '../models/dish.dart';
import '../models/ingredient.dart';

class DatabaseSchema {
  final List<Ingredient> ingredients;
  final int lastIngredientId;
  final List<Dish> dishes;
  final int lastDishId;

  DatabaseSchema({
    required this.ingredients,
    required this.lastIngredientId,
    required this.dishes,
    required this.lastDishId,
  });
}

void saveDatabase({
  required List<Ingredient> ingredients,
  required int lastIngredientId,
  required List<Dish> dishes,
  required int lastDishId,
}) {
  Map<String, dynamic> myJson = {
    'ingredients': ingredients
        .map(
          (ing) => ing.toJson(),
        )
        .toList(),
    'lastIngredientId': lastIngredientId,
    'dishes': dishes,
    'lastDishId': lastDishId
  };

  File("./app_db.json").writeAsStringSync(jsonEncode(myJson));
  print("Banco salvo com sucesso!");
}

DatabaseSchema loadDatabase() {
  String jsonString = File("./app_db.json").readAsStringSync();

  Map<String, dynamic> json = jsonDecode(jsonString);

  return DatabaseSchema(
    ingredients: json['ingredients']
        .map<Ingredient>(
          (ingredientJson) => Ingredient.fromJson(ingredientJson),
        )
        .toList(),
    lastIngredientId: json['lastIngredientId'],
    dishes: json['dishes'].map<Dish>(
          (dishJson) => Dish.fromJson(dishJson),
        )
        .toList(),
    lastDishId: json['lastDishId'],
  );
}
