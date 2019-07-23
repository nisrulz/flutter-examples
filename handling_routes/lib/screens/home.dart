import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        // Title
        title: Text("Home Page"),
        // App Bar background color
        backgroundColor: Colors.red,
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
                "Home Page\nClick on below icon to goto About Page",
                // Setting the style for the Text
                style: TextStyle(fontSize: 20.0,),
                // Set text alignment to center
                textAlign: TextAlign.center,
              ),
              // Icon Button
              IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
                // Execute when pressed
                onPressed: () {
                  // use the navigator to goto a named route
                  Navigator.of(context).pushNamed('/about');
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
