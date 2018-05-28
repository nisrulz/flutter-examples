import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    // Define the theme, set the primary swatch
    theme: new ThemeData(primarySwatch: Colors.green),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Declare some constants
    final double myTextSize = 30.0;
    final double myIconSize = 40.0;
    final TextStyle myTextStyle =
        new TextStyle(color: Colors.grey, fontSize: myTextSize);

    var column = new Column(
      // Makes the cards stretch in horizontal axis
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Setup the card
        new MyCard(
            // Setup the text
            title: new Text(
              "Favorite",
              style: myTextStyle,
            ),
            // Setup the icon
            icon:
                new Icon(Icons.favorite, size: myIconSize, color: Colors.red)),
        new MyCard(
            title: new Text(
              "Alarm",
              style: myTextStyle,
            ),
            icon: new Icon(Icons.alarm, size: myIconSize, color: Colors.blue)),
        new MyCard(
            title: new Text(
              "Airport Shuttle",
              style: myTextStyle,
            ),
            icon: new Icon(Icons.airport_shuttle,
                size: myIconSize, color: Colors.amber)),
        new MyCard(
            title: new Text(
              "Done",
              style: myTextStyle,
            ),
            icon: new Icon(Icons.done, size: myIconSize, color: Colors.green)),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Stateless Widget"),
      ),
      body: new Container(
        // Sets the padding in the main container
        padding: const EdgeInsets.only(bottom: 2.0),
        child: new Center(
          child: new SingleChildScrollView(child: column),
        ),
      ),
    );
    ;
  }
}

// Create a reusable stateless widget
class MyCard extends StatelessWidget {
  final Widget icon;
  final Widget title;

  // Constructor. {} here denote that they are optional values i.e you can use as: new MyCard()
  MyCard({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Card(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[this.title, this.icon],
          ),
        ),
      ),
    );
  }
}
