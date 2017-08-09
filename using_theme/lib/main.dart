import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("Using Theme"),
      ),
      body: new Container(
          child: new Center(
            child: new Text("Hello World!", style: new TextStyle(color: Colors.white),),
          ),
          decoration: new BoxDecoration(color: Colors.purple)),
    ),
    theme: new ThemeData(primarySwatch: Colors.deepPurple),
  ));
}
