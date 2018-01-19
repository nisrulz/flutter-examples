import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new ContactPage()));
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Using SnackBar"),
      ),
      body: new Center(
        child: new Text("Hello World!"),
      ),
    );
  }
}
