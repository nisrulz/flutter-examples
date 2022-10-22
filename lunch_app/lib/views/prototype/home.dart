import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lunch_app/views/prototype/widgets/category_selector.dart';
import 'package:lunch_app/views/prototype/widgets/food_lister.dart';
import 'package:lunch_app/views/prototype/widgets/options_selector.dart';

import 'bottom_nav/bottom_nav.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SvgPicture.asset(
            "assets/nav/drawer.svg",
            width: 25,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                OptionsSelector(
                  onChange: (x) {},
                ),
                CategorySelector(
                  onChange: (cat) {},
                ),
                FoodLister(),
              ],
            ),
          ),
          BottomNav(),
        ],
      ),
    );
  }
}
