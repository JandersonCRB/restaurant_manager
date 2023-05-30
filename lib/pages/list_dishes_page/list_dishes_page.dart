import 'package:biblioteca_ui/pages/list_dishes_page/edit_dish_ingredients_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../stores/restaurant_store.dart';
import 'add_dish_modal.dart';

class ListDishesPage extends StatefulWidget {
  const ListDishesPage({super.key});

  @override
  State<ListDishesPage> createState() => _ListDishesPageState();
}

class _ListDishesPageState extends State<ListDishesPage> {
  void openNewDishModal() {
    showDialog(
      context: context,
      builder: (context) => const AddDishModal(),
    );
  }

  void openEditDishIngredientsModal(int dishId) {
    showDialog(
      context: context,
      builder: (context) => EditDishIngredientsModal(dishId: dishId),
    );
  }

  @override
  Widget build(BuildContext context) {
    RestaurantStore restaurantStore = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text("Pratos")),
      body: Container(
        padding:
            const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FilledButton(
                onPressed: () => openNewDishModal(),
                child: const Text("Adicionar novo prato"),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Table(
                  columnWidths: const {0: FixedColumnWidth(45)},
                  children: [
                    const TableRow(
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        SizedBox(height: 40, child: Text("Nome")),
                        Text("Ingredientes"),
                        Text("Ações")
                      ],
                    ),
                    ...restaurantStore.dishes
                        .map(
                          (dish) => TableRow(
                            children: [
                              SizedBox(
                                child: restaurantStore
                                        .isDishAvaiable(dish.value.id!)
                                    ? const Tooltip(
                                        message: "Disponível",
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.green,
                                        ),
                                      )
                                    : const Tooltip(
                                        message: "Não disponível",
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 30,
                                child: Text(
                                  "${dish.value.name}",
                                ),
                              ),
                              Obx(
                                () => Text(
                                  restaurantStore.ingredientNames(
                                      dish.value.ingredientIds!),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 6),
                                  Tooltip(
                                    message: "Descontar do estoque",
                                    child: InkWell(
                                      onTap: () {
                                        restaurantStore.stockDiscount(dish.value.id!);
                                      },
                                      child: const Icon(
                                          Icons.keyboard_double_arrow_down,),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      openEditDishIngredientsModal(
                                        dish.value.id!,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () {
                                      restaurantStore
                                          .deleteDish(dish.value.id!);
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
