import 'package:flutter/material.dart';
import 'package:handling_routes/screens/about.dart';
import 'package:handling_routes/screens/home.dart';

void main() {
  runApp(new MaterialApp(
    home: new HomePage(), // home has implicit route set at '/'
    // Setup routes
    routes: <String, WidgetBuilder>{
      // Set named routes
      AboutPage.routeName: (BuildContext context) => new AboutPage(),
    },
  ));
}
