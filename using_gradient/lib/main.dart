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
              decoration: new BoxDecoration(
                // Add Gradient
                gradient: new LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.blueAccent],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.6, 0.0),
                    stops: [0.0, 0.6],
                    tileMode: TileMode.clamp),
              )))));
}
