import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyHome(),
  ));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<MyHome> {
  // Generate dialog
  AlertDialog dialog = new AlertDialog(
      content: new Text(
    "Hello World!",
    style: new TextStyle(fontSize: 30.0),
  ));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Using Alert Dialog"),
        ),
        body: new Container(
          child: new Center(
            child: new RaisedButton(
                child: new Text("Hit to alert!"),
                // On press of the button
                onPressed: () {
                  // Show dialog
                  showDialog(context: context, child: dialog);
                }),
          ),
        ));
  }
}
