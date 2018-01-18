import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new MyDrawerApp()));
}

class MyDrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListView listView = new ListView(
      children: <Widget>[
        getPaddedFirstText("Nav Item 1"),
        getPaddedText("Nav Item 2"),
        getPaddedText("Nav Item 3"),
        getPaddedText("Nav Item 4"),
      ],
    );
    Drawer myDrawer = new Drawer(
      child: listView,
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Navigation Drawer Example"),
      ),
      body: new Container(
          child: new Center(
        child: new Text("Hello World!"),
      )),
      drawer: myDrawer,
    );
  }

  Padding getPaddedFirstText(var data) {
    return new Padding(
        child: new Text(data),
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, bottom: .0, top: 40.0));
  }

  Padding getPaddedText(var data) {
    return new Padding(
        child: new Text(data), padding: const EdgeInsets.all(15.0));
  }
}
