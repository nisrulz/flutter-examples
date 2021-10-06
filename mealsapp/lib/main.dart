import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../screens/meal_details_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/category_meals_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'mealsapp',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          elevation: 6,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ).copyWith(
        // new way to add accentColor
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.white),
      ),

      home: TabsScreen(),
      // this is how you show a different screen

      routes: {
        /* '/category-meals' : (ctx) => CategoryMealsScreen(), */
        //or,
        CategoryMealsScreen.routes: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
    );
  }
}
