import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xfff4796b),
        brightness: Brightness.dark,
      ),
      home: Home(),
    );
  }
}
