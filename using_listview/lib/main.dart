import 'package:flutter/material.dart';
import 'package:using_listview/contact_page.dart';

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("Using Listview"),
      ),
      body: new ContactPage(),
    ),
  ));
}
