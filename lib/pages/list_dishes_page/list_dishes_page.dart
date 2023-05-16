import 'package:flutter/material.dart';

import '../../models/dish.dart';
import 'add_dish_modal.dart';

class ListDishesPage extends StatefulWidget {
  List<Dish> dishes;
  final void Function(String) addDish;
  final void Function(int) deleteDish;

  ListDishesPage({super.key, required this.addDish, required this.dishes, required this.deleteDish});

  @override
  State<ListDishesPage> createState() => _ListDishesPageState();
}

class _ListDishesPageState extends State<ListDishesPage> {
    void addDish(String dishName) {
    setState(() {
      widget.addDish(dishName);
    });
  }

  void openNewDishModal() {
    showDialog(
      context: context,
      builder: (context) => AddDishModal(
        addDish: addDish,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Table(
                children: [
                  const TableRow(children: [
                    SizedBox(height: 40, child: Text("Nome")),
                    Text("Ingredientes"),
                    Text("Ações")
                  ]),
                  ...widget.dishes
                      .map(
                        (dish) => TableRow(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Text(
                                "${dish.name}",
                              ),
                            ),
                            const Text("ingredientes"),
                            Row(
                              children: [
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      // widget.decreaseQuantity(ingredient.id!);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.deleteDish(dish.id!);
                                    });
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
