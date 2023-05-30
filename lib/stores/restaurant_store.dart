import 'package:get/get.dart';

import '../models/dish.dart';
import '../models/ingredient.dart';

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
    if (dishes.any((Ingredient) =>
        Ingredient.value.name!.toLowerCase() == dishName.toLowerCase())) {
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
    dishes.removeWhere((Ingredient) => Ingredient.value.id == dishId);
  }

  Rx<Dish>? findDish(int id) {
    return dishes.firstWhere((Ingredient) => Ingredient.value.id == id);
  }

  void addIngredientToDish(int dishId, int ingredientId) {
    Rx<Dish>? Ingredient = findDish(dishId);
    if (Ingredient == null) {
      return;
    }

    Ingredient.update((newDish) {
      if (!newDish!.ingredientIds!
          .any((newIngredientId) => newIngredientId == ingredientId)) {
        newDish.ingredientIds!.add(ingredientId);
      }
    });
  }

  String ingredientNames(List<int> ingredientIds) {
    List<String> currentIngredients = ingredients
        .where(
          (ingredient) => ingredientIds.any((id) => ingredient.value.id == id),
        )
        .map((ingredient) => ingredient.value.name!)
        .toList();
    if (currentIngredients.isEmpty) {
      return "Nenhum ingrediente";
    }
    return currentIngredients.join(", ");
  }

  Rx<Ingredient> findIngredientById(int id) {
    return ingredients.firstWhere((ingredient) => ingredient.value.id == id);
  }

  void deleteIngredientFromDish(int dishId, int ingredientId) {
    Rx<Dish>? dish = findDish(dishId);

    dish!.update((currentDish) {
      currentDish!.ingredientIds!.removeWhere(
          (currentIngredientId) => currentIngredientId == ingredientId);
    });
  }

  bool isDishAvaiable(int dishId) {
    Dish dish = findDish(dishId)!.value;

    for(int i = 0;i < dish.ingredientIds!.length;i++) {
      int ingredientId = dish.ingredientIds![i];
      Ingredient ingredient = findIngredientById(ingredientId).value;

      if(ingredient.quantity! <= 0) {
        return false;
      } 
    }

    return true;
  }

  void stockDiscount(int dishId) {
    if(!isDishAvaiable(dishId)) {
      return;
    }
    
    Dish dish = findDish(dishId)!.value;

    for(int i = 0;i < dish.ingredientIds!.length;i++) {
      int ingredientId = dish.ingredientIds![i];
      Rx<Ingredient> ingredient = findIngredientById(ingredientId);

      ingredient.update((ing) { 
        ing!.quantity = ing.quantity! - 1;
      });
    }
  }
}
