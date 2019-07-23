import 'package:flutter/material.dart';

import './utils.dart' as utils;

void main() {
  runApp(MaterialApp(
      // Title
      title: "Using Custom Fonts",
      // Home
      home: Scaffold(
        // Appbar
        appBar: AppBar(
          // Title
          title: Text("Using Custom Fonts"),
        ),
        // Body
        body: Container(
          // Center the content
          child: Center(
            // Add Text
            child: Text("The quick brown fox jumps over the lazy dog",
                // Center align text
                textAlign: TextAlign.center,
                // set a text style which defines a custom font
                style: utils.getCustomFontTextStyle()),
          ),
        ),
      )));
}
