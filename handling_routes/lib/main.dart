import 'package:flutter/material.dart';

import './AboutPage.dart';
import './HomePage.dart';

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
    // Setup routes
    routes: <String, WidgetBuilder>{
      // Set named routes
      "/about": (BuildContext context) => new AboutPage(),
    },
  ));
}
