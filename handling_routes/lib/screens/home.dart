import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // AppBar
      appBar: new AppBar(
        // Title
        title: new Text("Home Page"),
        // App Bar background color
        backgroundColor: Colors.red,
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
                "Home Page\nClick on below icon to goto About Page",
                // Setting the style for the Text
                style: new TextStyle(fontSize: 20.0,),
                // Set text alignment to center
                textAlign: TextAlign.center,
              ),
              // Icon Button
              new IconButton(
                icon: new Icon(
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
