import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // AppBar
      appBar: new AppBar(
        // Title
        title: new Text("About Page"),
        // App Bar background color
        backgroundColor: Colors.blue,
      ),
      // Body
      body: new Container(
        // Center the content
        child: new Center(
          child: new Column(
            // Center content in the column
            mainAxisAlignment: MainAxisAlignment.center,
            // add children to the column
            children: <Widget>[
              // Text
              new Text(
                "About Page\nClick on below icon to goto Home Page",
                // Setting the style for the Text
                style: new TextStyle(fontSize: 20.0),
                // Set text alignment to center
                textAlign: TextAlign.center,
              ),
              // Icon Button
              new IconButton(
                icon: new Icon(
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
