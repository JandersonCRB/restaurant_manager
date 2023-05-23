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
                  children: [
                    const TableRow(children: [
                      SizedBox(height: 40, child: Text("Nome")),
                      Text("Ingredientes"),
                      Text("Ações")
                    ]),
                    ...restaurantStore.dishes
                        .map(
                          (dish) => TableRow(
                            children: [
                              SizedBox(
                                height: 30,
                                child: Text(
                                  "${dish.value.name}",
                                ),
                              ),
                              const Text("ingredientes"),
                              Row(
                                children: [
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () {
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
