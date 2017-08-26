import 'package:flutter/material.dart';

import './FirstTab.dart' as first_tab;
import './SecondTab.dart' as second_tab;
import './ThirdTab.dart' as third_tab;

void main() {
  runApp(new MaterialApp(
      // Title
      title: "Using Tabs",
      // Home
      home: new MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // Appbar
        appBar: new AppBar(
          // Title
          title: new Text("Using Tabs"),
          backgroundColor: Colors.blue,
          bottom: new TabBar(
            tabs: <Tab>[
              new Tab(
                icon: new Icon(Icons.favorite),
              ),
              new Tab(
                icon: new Icon(Icons.adb),
              ),
              new Tab(
                icon: new Icon(Icons.airport_shuttle),
              ),
            ],
            controller: controller,
          ),
        ),
        // Body
        body: new TabBarView(
          children: <Widget>[
            new first_tab.First(),
            new second_tab.Second(),
            new third_tab.Third()
          ],
          controller: controller,
        ));
  }
}
