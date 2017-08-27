import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      // AppBar
      appBar: new AppBar(
        // AppBar Title
        title: new Text("Using Theme"),
      ),
      body: new Container(
          child: new Center(
            child: new Text(
              "Hello World!",
              // Set the text style, text color to white
              style: new TextStyle(color: Colors.white),
            ),
          ),
          // Another way to set the background color
          decoration: new BoxDecoration(color: Colors.lightBlueAccent)),
    ),
    // Set the theme's primary color, accent color,
    theme: new ThemeData(
      primarySwatch: Colors.blue,
      accentColor: Colors.lightBlueAccent,
      backgroundColor: Colors.blueAccent,
    ),
  ));
}
