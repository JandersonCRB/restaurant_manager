import 'package:biblioteca_ui/models/ingredient.dart';
import 'package:get/get.dart';

import '../models/dish.dart';

class RestaurantStore extends GetxController {
  var ingredients = <Rx<Ingredient>>[].obs;
  var dishes = <Rx<Dish>>[].obs;
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
        id: lastIngredientId.value,
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

    void addDish(String dishName) {
    if (dishes
        .any((dish) => dish.value.name!.toLowerCase() == dishName.toLowerCase())) {
      return;
    }

    dishes.add(
      Dish(
        id: lastDishId.value,
        name: dishName,
        ingredientIds: [],
      ).obs,
    );

    lastDishId++;
  }

  void deleteDish(int dishId) {
    dishes.removeWhere((dish) => dish.value.id == dishId);
  }
}
