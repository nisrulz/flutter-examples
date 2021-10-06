import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key}) : super(key: key);

  static const routeName = 'meal-details';

  @override
  Widget build(BuildContext context) {
    final Id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == Id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedMeal.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                elevation: 6,
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 2),
                      child: Text(
                        'Ingredients',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Container(
                      height: 135,
                      width: double.infinity,
                      child: ListView.builder(
                          itemBuilder: (ctx, index) => Container(
                                padding: EdgeInsets.all(10),
                                height: 36,
                                width: double.infinity,
                                child: Text(
                                  selectedMeal.ingredients[index],
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                          itemCount: selectedMeal.ingredients.length),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Recipe',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                          child: Text('#'),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      itemCount: selectedMeal.steps.length,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
