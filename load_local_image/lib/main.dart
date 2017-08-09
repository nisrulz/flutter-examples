import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Load local image"),
        ),
        body: new Container(
          child: new Center(
            child: new Text("Hellow World!"),
          ),
          // Set the image as the background of the Container
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  // Load image from assets
                  image: new AssetImage('data_repo/img/bg1.jpg'),
                  // Make the image cover the whole area
                  fit: BoxFit.cover)),
        ));
  }
}
