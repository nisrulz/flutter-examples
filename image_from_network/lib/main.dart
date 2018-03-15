import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Image from Network"),
        ),
        body: new Container(
          child: new Center(child: new Text("Hello World")),
        ),
      ),
    );
  }
}