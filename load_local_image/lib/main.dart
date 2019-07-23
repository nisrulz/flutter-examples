import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Load local image"),
        ),
        body: Container(
          child: Center(
            child: Text(
              "Hello World!",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Set the image as the background of the Container
          decoration: BoxDecoration(
              image: DecorationImage(
                  // Load image from assets
                  image: AssetImage('data_repo/img/bg1.jpg'),
                  // Make the image cover the whole area
                  fit: BoxFit.cover)),
        ));
  }
}
