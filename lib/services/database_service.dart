import 'dart:convert';
import 'dart:io';

import '../models/ingredient.dart';

class DatabaseSchema {
  final List<Ingredient> ingredients;
  final int lastIngredientId;

  DatabaseSchema({required this.ingredients, required this.lastIngredientId});
}

void saveDatabase({required List<Ingredient> ingredients, required int lastIngredientId}) {
  Map<String, dynamic> myJson = {
    'ingredients': ingredients
        .map(
          (ing) => ing.toJson(),
        )
        .toList(),
    'lastIngredientId': lastIngredientId,
  };

  File("./app_db.json").writeAsStringSync(jsonEncode(myJson));
  print("Banco salvo com sucesso!");
}

DatabaseSchema loadDatabase() {
  String jsonString = File("./app_db.json").readAsStringSync();

  Map<String, dynamic> json = jsonDecode(jsonString);

  return DatabaseSchema(
    ingredients: json['ingredients'].map<Ingredient>(
      (ingredientJson) => Ingredient.fromJson(ingredientJson),
    ).toList(),
    lastIngredientId: json['lastIngredientId']
  );
}
