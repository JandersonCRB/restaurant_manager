import 'package:flutter/material.dart';
import '../../models/ingredient.dart';
import 'add_ingredient_modal.dart';

class ListIngredientsPage extends StatefulWidget {
  final List<Ingredient> ingredients;
  final void Function(String) addIngredient;
  final void Function(int) deleteIngredient;
  final void Function(int) increaseQuantity;
  final void Function(int) decreaseQuantity;

  const ListIngredientsPage({
    super.key,
    required this.ingredients,
    required this.addIngredient,
    required this.deleteIngredient,
    required this.increaseQuantity,
    required this.decreaseQuantity,
  });

  @override
  State<ListIngredientsPage> createState() => _ListIngredientsPageState();
}

class _ListIngredientsPageState extends State<ListIngredientsPage> {
  void addIngredient(String ingredientName) {
    setState(() {
      widget.addIngredient(ingredientName);
    });
  }

  void openNewIngredientModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddIngredientModal(addIngredient: (ingredientName) {
        setState(() {
          widget.addIngredient(ingredientName);
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Table(
                children: [
                  const TableRow(children: [
                    SizedBox(height: 40, child: Text("Nome")),
                    Text("Quantidade"),
                    Text("Ações")
                  ]),
                  ...widget.ingredients
                      .map(
                        (ingredient) => TableRow(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Text(
                                "${ingredient.name}",
                              ),
                            ),
                            Text("${ingredient.quantity}"),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.increaseQuantity(ingredient.id!);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.decreaseQuantity(ingredient.id!);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.deleteIngredient(ingredient.id!);
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
