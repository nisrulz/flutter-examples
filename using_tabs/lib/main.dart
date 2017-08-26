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

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
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
          // Set the background color of the App Bar
          backgroundColor: Colors.blue,
          // Set the bottom property of the Appbar to include a Tab Bar
          bottom: new TabBar(
            tabs: <Tab>[
              new Tab(
                // set icon to the tab
                icon: new Icon(Icons.favorite),
              ),
              new Tab(
                icon: new Icon(Icons.adb),
              ),
              new Tab(
                icon: new Icon(Icons.airport_shuttle),
              ),
            ],
            // setup the controller
            controller: controller,
          ),
        ),
        // Set the TabBar view as the body of the Scaffold
        body: new TabBarView(
          // Add tabs as widgets
          children: <Widget>[
            new first_tab.First(),
            new second_tab.Second(),
            new third_tab.Third()
          ],
          // set the controller
          controller: controller,
        ));
  }
}
