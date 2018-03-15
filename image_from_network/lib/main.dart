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
            child: new Column(
          children: <Widget>[
            // Load image from network
            new Image.network(
                'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/flutter_logo.png'),
            // even loads gifs
            // Gif image from Giphy, all copyrights are owned by Giphy
            new Image.network(
                'https://github.com/nisrulz/flutter-examples/raw/develop/image_from_network/img/loop_anim.gif'),
          ],
        )),
      ),
    );
  }
}
