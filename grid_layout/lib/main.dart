import 'package:flutter/material.dart';
import 'package:grid_layout/gridview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MyGridView myGridView = MyGridView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("GridView Example"),
        ),
        body: myGridView.build(),
      ),
    );
  }
}
