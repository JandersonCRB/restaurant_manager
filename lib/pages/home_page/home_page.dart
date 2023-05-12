import 'package:biblioteca_ui/models/ingredient.dart';
import 'package:flutter/material.dart';

import '../list_ingredients_page/list_ingredients_page.dart';

int id = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Ingredient> ingredients = [];

  void addIngredient(String ingredientName) {
    if (ingredients.any((ingredient) =>
        ingredient.name!.toLowerCase() == ingredientName.toLowerCase())) {
      return;
    }
    ingredients.add(Ingredient(id: id++, name: ingredientName, quantity: 0));
  }

  void deleteIngredient(int id) {
    ingredients.removeWhere((ingredient) => ingredient.id == id);
  }

  void increaseQuantity(int id) {
    Ingredient ingredient = ingredients.firstWhere((ingredient) => ingredient.id == id);
    ingredient.quantity = ingredient.quantity! + 1;
  }

  void decreaseQuantity(int id) {
    Ingredient ingredient = ingredients.firstWhere((ingredient) => ingredient.id == id);
    if (ingredient.quantity! > 0) {
      ingredient.quantity = ingredient.quantity! - 1;
    }
  }

  void openIngredientsPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ListIngredientsPage(
          ingredients: ingredients,
          addIngredient: addIngredient,
          deleteIngredient: deleteIngredient,
          increaseQuantity: increaseQuantity,
          decreaseQuantity: decreaseQuantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/minimessi.png"),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 62,
            ),
            const Text(
              "Bar do minimessi",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            const SizedBox(
              height: 62,
            ),
            FilledButton(
              onPressed: () => openIngredientsPage(context),
              child: const Text("INGREDIENTES"),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
              onPressed: () {},
              child: const Text("PRATOS"),
            ),
          ],
        ),
      ),
    );
  }
}
