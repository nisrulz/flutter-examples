import 'package:flutter/material.dart';
import 'package:handling_routes/screens/about.dart';
import 'package:handling_routes/screens/home.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(), // home has implicit route set at '/'
    // Setup routes
    routes: <String, WidgetBuilder>{
      // Set named routes
      AboutPage.routeName: (BuildContext context) => AboutPage(),
    },
  ));
}
