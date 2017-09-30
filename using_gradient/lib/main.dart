import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      // Title
      title: "Using Gradient",
      // Home
      home: new Scaffold(
          // Appbar
          appBar: new AppBar(
            // Title
            title: new Text("Using Gradient"),
          ),
          // Body
          body: new Container(
            // Center the content
            child: new Center(
              // Add Text
              child: new Text(
                "Hello World!",
              ),
            ),
          ))));
}
