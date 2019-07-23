import 'package:flutter/material.dart';
import 'package:using_listview/contact_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("Using Listview"),
      ),
      body: ContactPage(),
    ),
  ));
}
