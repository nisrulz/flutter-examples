import 'package:flutter/material.dart';

import './utils.dart' as utils;

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
              // Set background
              decoration: new BoxDecoration(
                  // Add Gradient
                  gradient: utils.getCustomGradient())))));
}
