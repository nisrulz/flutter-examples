import 'package:flutter/material.dart';

void main() {
  var nameOfApp = "Persist Key Value";

  runApp(new MaterialApp(
      // Title
      title: nameOfApp,
      // Home
      home: new Scaffold(
        // Appbar
        appBar: new AppBar(
          // Title
          title: new Text(nameOfApp),
        ),
        // Body
        body: new Container(
          // Center the content
          child: new Center(
            // Add Text
            child: new Text("Hello World!"),
          ),
        ),
      )));
}
