import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      title: "Simple Material App",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Simple Material App"),
        ),
        body: new Container(
          child: new Center(
            child: new Text("Hello World!"),
          ),
        ),
      )));
}
