// for one particular region's food show screen

import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routes = '/category-meals';
  // defining it here for less errors

  @override
  Widget build(BuildContext context) {
    final argsTaker =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // !. => null checker

    // accepting arguments from route method like this
    final String catTitle = argsTaker['title'] as String;
    final String catId = argsTaker['id'] as String;

    final categoryMeals = dummyMeals.where((meal) {
      return meal.categories.contains(catId);
      // checks id matches or not and returns true or false
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
              duration: categoryMeals[index].duration,
            );
            // passing to display and design meals
          },
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }
}
