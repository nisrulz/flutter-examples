import 'package:flutter/material.dart';

import './utils.dart' as utils;

void main() {
  runApp(new MaterialApp(
      // Title
      title: "Using Custom Fonts",
      // Home
      home: new Scaffold(
        // Appbar
        appBar: new AppBar(
          // Title
          title: new Text("Using Custom Fonts"),
        ),
        // Body
        body: new Container(
          // Center the content
          child: new Center(
            // Add Text
            child: new Text("The quick brown fox jumps over the lazy dog",
                // Center align text
                textAlign: TextAlign.center,
                // set a text style which defines a custom font
                style: utils.getCustomFontTextStyle()),
          ),
        ),
      )));
}
