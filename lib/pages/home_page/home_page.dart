import 'dart:async';

import 'package:biblioteca_ui/models/ingredient.dart';
import 'package:biblioteca_ui/pages/list_dishes_page/list_dishes_page.dart';
import 'package:biblioteca_ui/services/database_service.dart';
import 'package:flutter/material.dart';

import '../../models/dish.dart';
import '../list_ingredients_page/list_ingredients_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int ingredientId = 0;
  int dishId = 0;
  List<Ingredient> ingredients = [];
  List<Dish> dishes = [];

  void _saveDatabase() {
    saveDatabase(ingredients: ingredients, lastIngredientId: ingredientId, dishes: dishes, lastDishId: dishId);
  }

  void _loadDatabase() {
    DatabaseSchema db = loadDatabase();

    // ingredients
    ingredients = db.ingredients;
    ingredientId = db.lastIngredientId;

    dishes = db.dishes;


    print("Database loaded");
  }

  @override
  void initState() {
    super.initState();

    _loadDatabase();

    Timer.periodic(const Duration(seconds: 5), (_) => _saveDatabase());
  }

  void addIngredient(String ingredientName) {
    if (ingredients.any((ingredient) =>
        ingredient.name!.toLowerCase() == ingredientName.toLowerCase())) {
      return;
    }
    ingredients
        .add(Ingredient(id: ingredientId++, name: ingredientName, quantity: 0));
  }

  void deleteIngredient(int ingredientId) {
    ingredients.removeWhere((ingredient) => ingredient.id == ingredientId);
  }

  void increaseQuantity(int ingredientId) {
    Ingredient ingredient =
        ingredients.firstWhere((ingredient) => ingredient.id == ingredientId);
    ingredient.quantity = ingredient.quantity! + 1;
  }

  void decreaseQuantity(int ingredientId) {
    Ingredient ingredient =
        ingredients.firstWhere((ingredient) => ingredient.id == ingredientId);
    if (ingredient.quantity! > 0) {
      ingredient.quantity = ingredient.quantity! - 1;
    }
  }

  void addDish(String dishName) {
    if (dishes
        .any((dish) => dish.name!.toLowerCase() == dishName.toLowerCase())) {
      return;
    }
    dishes.add(
      Dish(
        id: dishId++,
        name: dishName,
        ingredientIds: [],
      ),
    );
  }

  void deleteDish(int dishId) {
    dishes.removeWhere((dish) => dish.id == dishId);
  }

  void openIngredientsPage() {
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

  void openDishesPage() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ListDishesPage(
            addDish: addDish,
            dishes: dishes,
            deleteDish: deleteDish,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black87,
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
                  color: Colors.white),
            ),
            const SizedBox(
              height: 62,
            ),
            FilledButton(
              onPressed: () => openIngredientsPage(),
              child: const Text("INGREDIENTES"),
            ),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
              onPressed: () => openDishesPage(),
              child: const Text("PRATOS"),
            ),
          ],
        ),
      ),
    );
  }
}
