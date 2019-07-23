import 'package:flutter/material.dart';

import './utils.dart' as utils;

void main() {
  runApp(MaterialApp(
      // Title
      title: "Using Gradient",
      // Home
      home: Scaffold(
          // Appbar
          appBar: AppBar(
            // Title
            title: Text("Using Gradient"),
          ),
          // Body
          body: Container(
              // Center the content
              child: Center(
                // Add Text
                child: Text(
                  "Hello World!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Set background
              decoration: BoxDecoration(
                  // Add Gradient
                  gradient: utils.getCustomGradient())))));
}
