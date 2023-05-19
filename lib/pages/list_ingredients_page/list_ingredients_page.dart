import 'package:biblioteca_ui/stores/restaurant_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_ingredient_modal.dart';

class ListIngredientsPage extends StatelessWidget {
  const ListIngredientsPage({
    super.key,
  });

  void openNewIngredientModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddIngredientModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    RestaurantStore restaurantStore = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingredientes"),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FilledButton(
                child: const Text("Adicionar novo ingrediente"),
                onPressed: () {
                  openNewIngredientModal(context);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Table(
                  children: [
                    const TableRow(children: [
                      SizedBox(height: 40, child: Text("Nome")),
                      Text("Quantidade"),
                      Text("Ações")
                    ]),
                    ...restaurantStore.ingredients
                        .map(
                          (ingredient) => TableRow(
                            children: [
                              SizedBox(
                                height: 30,
                                child: Text(
                                  "${ingredient.value.name}",
                                ),
                              ),
                              Text("${ingredient.value.quantity}"),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      restaurantStore.increaseQuantity(
                                          ingredient.value.id!);
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () {
                                      restaurantStore.decreaseQuantity(
                                          ingredient.value.id!);
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () {
                                      restaurantStore.deleteIngredient(
                                          ingredient.value.id!);
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
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
