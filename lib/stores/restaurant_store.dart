import 'package:biblioteca_ui/models/ingredient.dart';
import 'package:get/get.dart';

import '../models/dish.dart';

class RestaurantStore extends GetxController {
  var ingredients = <Rx<Ingredient>>[].obs;
  var dishes = <Dish>[].obs;
  var lastIngredientId = 0.obs;
  var lastDishId = 0.obs;

  void addIngredient(String ingredientName) {
    if (ingredients.any(
      (ingredient) =>
          ingredient.value.name!.toLowerCase() == ingredientName.toLowerCase(),
    )) {
      return;
    }
    ingredients.add(
      Ingredient(
        id: lastIngredientId.toInt(),
        name: ingredientName,
        quantity: 0,
      ).obs,
    );
    lastIngredientId++;
  }

  void deleteIngredient(int ingredientId) {
    ingredients
        .removeWhere((ingredient) => ingredient.value.id == ingredientId);
  }

  void increaseQuantity(int ingredientId) {
    var ingredient = ingredients
        .firstWhere((ingredient) => ingredient.value.id == ingredientId);
    ingredient.update((i) {
      i?.quantity = i.quantity! + 1;
    });
  }

  void decreaseQuantity(int ingredientId) {
    var ingredient = ingredients
        .firstWhere((ingredient) => ingredient.value.id == ingredientId);
    if (ingredient.value.quantity! > 0) {
      ingredient.update((i) {
        i?.quantity = i.quantity! - 1;
      });
    }
  }
}
