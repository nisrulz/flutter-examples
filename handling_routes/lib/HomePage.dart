import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
        backgroundColor: Colors.red,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Home Page\nClick on below icon to goto About Page",
                style: new TextStyle(fontSize: 20.0),
              ),
              new IconButton(
                icon: new Icon(
                  Icons.info,
                  color: Colors.green,
                ),
                onPressed: () {
                  // use the navigator to goto a named route
                  Navigator.of(context).pushNamed('/about');
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
