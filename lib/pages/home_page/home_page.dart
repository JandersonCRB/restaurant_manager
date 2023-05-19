import 'dart:async';

import 'package:biblioteca_ui/models/ingredient.dart';
import 'package:biblioteca_ui/pages/list_dishes_page/list_dishes_page.dart';
import 'package:biblioteca_ui/services/database_service.dart';
import 'package:biblioteca_ui/stores/restaurant_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/dish.dart';
import '../list_ingredients_page/list_ingredients_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int dishId = 0;
  List<Dish> dishes = [];

  void _saveDatabase() {
    RestaurantStore restaurantStore = Get.find();
    saveDatabase(
        ingredients: restaurantStore.ingredients.value.map((ingredient) => ingredient.value).toList(),
        lastIngredientId: restaurantStore.lastIngredientId.value,
        dishes: dishes,
        lastDishId: dishId);
  }

  void _loadDatabase(RestaurantStore restaurantStore) {
    DatabaseSchema db = loadDatabase();

    // ingredients
    restaurantStore.ingredients = db.ingredients.map<Rx<Ingredient>>((ingredient) => ingredient.obs).toList().obs;
    restaurantStore.lastIngredientId = db.lastIngredientId.obs;

    dishes = db.dishes;

    print("Database loaded");
  }

  @override
  void initState() {
    super.initState();

    var restaurantStore = Get.put(RestaurantStore());

    _loadDatabase(restaurantStore);

    Timer.periodic(const Duration(seconds: 5), (_) => _saveDatabase());
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
        builder: (BuildContext context) => const ListIngredientsPage(),
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
