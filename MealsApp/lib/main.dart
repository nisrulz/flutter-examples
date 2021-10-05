import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_proj5meal/screens/meal_details_screen.dart';
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
      title: 'Meal',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        appBarTheme: AppBarTheme(
          color: Colors.red,
          elevation: 6,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
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
      // adding routes

      /* onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoryMealsScreen(),
        );
      }, */
      // if no routes found then go to this route by default => onGenerateRoute

      /* onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoryMealsScreen(),
        );
      }, */
      // if no route is found go to this route, its like the 404 error route on websites
    );
  }
}
