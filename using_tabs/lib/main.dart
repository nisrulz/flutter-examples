import 'package:flutter/material.dart';
import 'package:using_tabs/tabs/first.dart';
import 'package:using_tabs/tabs/second.dart';
import 'package:using_tabs/tabs/third.dart';

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
  /*
   *-------------------- Setup Tabs ------------------*
   */
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

  TabBar getTabBar() {
    return new TabBar(
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
    );
  }

  TabBarView getTabBarView(var tabs) {
    return new TabBarView(
      // Add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  /*
   *-------------------- Setup the page by setting up tabs in the body ------------------*
   */
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
            bottom: getTabBar()),
        // Set the TabBar view as the body of the Scaffold
        body: getTabBarView(<Widget>[new First(), new Second(), new Third()]));
  }
}
