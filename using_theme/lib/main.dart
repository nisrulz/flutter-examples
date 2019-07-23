import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHome(),
    // Set the theme's primary color, accent color,
    theme: ThemeData(
      primarySwatch: Colors.green,
      accentColor: Colors.lightGreenAccent,
      // Set background color
      backgroundColor: Colors.black12,
    ),
  ));
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        // AppBar Title
        title: Text("Using Theme"),
      ),
      body: Container(
        // Another way to set the background color
        decoration: BoxDecoration(color: Colors.black87),
        child: Center(
          child: Container(
            // use the theme accent color as background color for this widget
            color: Theme.of(context).accentColor,
            child: Text(
              'Hello World!',
              // Set text style as per theme
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),

      floatingActionButton: Theme(
        // override the accent color of theme for this widget only
        data: Theme.of(context).copyWith(
          colorScheme:
              Theme.of(context).colorScheme.copyWith(secondary: Colors.pinkAccent),
        ),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
