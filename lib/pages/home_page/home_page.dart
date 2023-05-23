import 'dart:async';

import 'package:biblioteca_ui/pages/list_dishes_page/list_dishes_page.dart';
import 'package:biblioteca_ui/services/database_service.dart';
import 'package:biblioteca_ui/stores/restaurant_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/dish.dart';
import '../../models/ingredient.dart';
import '../list_ingredients_page/list_ingredients_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _saveDatabase() {
    RestaurantStore restaurantStore = Get.find();
    saveDatabase(
      ingredients:
          restaurantStore.ingredients.value.map((dish) => dish.value).toList(),
      lastIngredientId: restaurantStore.lastIngredientId.value,
      dishes: restaurantStore.dishes.value.map((dish) => dish.value).toList(),
      lastDishId: restaurantStore.lastDishId.value,
    );
  }

  void _loadDatabase(RestaurantStore restaurantStore) {
    DatabaseSchema db = loadDatabase();

    // ingredients
    restaurantStore.ingredients = db.ingredients
        .map<Rx<Ingredient>>((ingredient) => ingredient.obs)
        .toList()
        .obs;
    restaurantStore.lastIngredientId = db.lastIngredientId.obs;

    restaurantStore.dishes =
        db.dishes.map<Rx<Dish>>((ingredient) => ingredient.obs).toList().obs;
    restaurantStore.lastDishId = db.lastDishId.obs;

    print("Database loaded");
  }

  @override
  void initState() {
    super.initState();

    var restaurantStore = Get.put(RestaurantStore());

    _loadDatabase(restaurantStore);

    Timer.periodic(const Duration(seconds: 5), (_) => _saveDatabase());
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
        builder: (BuildContext context) => const ListDishesPage(),
      ),
    );
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
