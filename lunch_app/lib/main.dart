import 'package:flutter/material.dart';
import 'package:lunch_app/views/prototype/food_detail_view.dart';

import 'views/prototype/home.dart';

void main() => runApp(LunchApp());

class LunchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: Home(),
      // home: FoodDetailView(),
    );
  }
}
