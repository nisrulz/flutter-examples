import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
          child: Center(
        child: Text("Settings Screen"),
      )),
    );
  }
}
