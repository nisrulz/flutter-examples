import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      // Title
      title: "Simple Material App",
      // Home
      home: Scaffold(
        // Appbar
        appBar: AppBar(
          // Title
          title: Text("Simple Material App"),
        ),
        // Body
        body: Container(
          // Center the content
          child: Center(
            // Add Text
            child: Text("Hello World!"),
          ),
        ),
      )));
}