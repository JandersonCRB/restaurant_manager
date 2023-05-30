import 'package:biblioteca_ui/stores/restaurant_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/ingredient.dart';
import '../../models/dish.dart';

class EditDishIngredientsModal extends StatefulWidget {
  final int dishId;

  EditDishIngredientsModal({
    super.key,
    required this.dishId,
  });

  @override
  State<EditDishIngredientsModal> createState() =>
      _EditDishIngredientsModalState();
}

class _EditDishIngredientsModalState extends State<EditDishIngredientsModal> {
  var currentIgredientId = 0.obs;

  @override
  void initState() {
    RestaurantStore restaurantStore = Get.find();
    currentIgredientId = restaurantStore.ingredients.first.value.id!.obs;
    super.initState();
  }

  void changeCurrentIngredient(int newId) {
    currentIgredientId.value = newId;
  }

  void addIngredientToDish() {
    RestaurantStore restaurantStore = Get.find();
    Rx<Dish>? dish = restaurantStore.findDish(widget.dishId);

    restaurantStore.addIngredientToDish(
        dish!.value.id!, currentIgredientId.value);
  }

  @override
  Widget build(BuildContext context) {
    RestaurantStore restaurantStore = Get.find();
    Rx<Dish>? dish = restaurantStore.findDish(widget.dishId);

    if (dish == null) {
      return const Dialog(
        child: Text("Este dish não existe"),
      );
    }

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Modificar ingredientes de ${dish.value.name}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(
              () => Table(
                children: [
                  const TableRow(
                    children: [
                      SizedBox(height: 40, child: Text("Ingrediente")),
                      Text("Ações")
                    ],
                  ),
                  ...dish.value.ingredientIds!.map(
                    (ingredientId) {
                      Rx<Ingredient> ingredient =
                          restaurantStore.findIngredientById(ingredientId);
                      return TableRow(
                        children: [
                          SizedBox(
                            height: 25,
                            child: Text(ingredient.value.name!),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  restaurantStore.deleteIngredientFromDish(
                                      dish.value.id!, ingredientId);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ).toList()
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => SizedBox(
                    width: 200,
                    height: 55,
                    child: DropdownButtonFormField<int>(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      value: currentIgredientId.value,
                      items: restaurantStore.ingredients.value
                          .map(
                            (ingredient) => DropdownMenuItem<int>(
                              value: ingredient.value.id,
                              child: Text(ingredient.value.name!),
                            ),
                          )
                          .toList(),
                      onChanged: (id) => changeCurrentIngredient(id!),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                FilledButton(
                  onPressed: addIngredientToDish,
                  child: const Text("Adicionar ingrediente"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
