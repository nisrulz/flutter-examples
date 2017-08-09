import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About Page"),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "About Page\nClick on below icon to goto Home Page",
                style: new TextStyle(fontSize: 20.0),
              ),
              new IconButton(
                icon: new Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                onPressed: () {
                  // use the navigator to goto a named route
                  Navigator.of(context).pushNamed('/');
                },
                iconSize: 80.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
