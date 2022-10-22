import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lunch_app/views/prototype/widgets/carousel_indicator.dart';

class FoodDetailView extends StatefulWidget {
  @override
  _FoodDetailViewState createState() => _FoodDetailViewState();
}

class _FoodDetailViewState extends State<FoodDetailView> {
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Deals of the week"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              onPageChanged: (i) {
                setState(() {
                  _currentPage = i;
                });
              },
              itemBuilder: (c, i) {
                return Image.asset(
                  "assets/images/burger.png",
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselIndicator(length: 3, selected: _currentPage),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delicious Burger",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Who doesn't love a big,\ntender, juicy burger?",
                      style:
                          TextStyle(color: Colors.grey.shade300, height: 1.5),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
