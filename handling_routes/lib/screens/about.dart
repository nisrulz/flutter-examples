import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = "/about";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        // Title
        title: Text("About Page"),
        // App Bar background color
        backgroundColor: Colors.blue,
      ),
      // Body
      body: Container(
        // Center the content
        child: Center(
          child: Column(
            // Center content in the column
            mainAxisAlignment: MainAxisAlignment.center,
            // add children to the column
            children: <Widget>[
              // Text
              Text(
                "About Page\nClick on below icon to goto Home Page",
                // Setting the style for the Text
                style: TextStyle(fontSize: 20.0),
                // Set text alignment to center
                textAlign: TextAlign.center,
              ),
              // Icon Button
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                // Execute when pressed
                onPressed: () {
                  // use the navigator to goto a named route
                  Navigator.of(context).pushNamed('/');
                },
                // Setting the size of icon
                iconSize: 80.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
