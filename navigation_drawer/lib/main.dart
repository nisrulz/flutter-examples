import 'package:flutter/material.dart';
import 'package:navigation_drawer/screens/account.dart';
import 'package:navigation_drawer/screens/home.dart';
import 'package:navigation_drawer/screens/settings.dart';

void main() {
  runApp(new MaterialApp(
    home: new HomeScreen(), // route for home is '/' implicitly
    routes: <String, WidgetBuilder>{
      // define the routes
      SettingsScreen.routeName: (BuildContext context) => new SettingsScreen(),
      AccountScreen.routeName: (BuildContext context) => new AccountScreen(),
    },
  ));
}
