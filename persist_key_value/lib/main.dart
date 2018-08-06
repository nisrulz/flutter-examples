import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
      // Disable the debug flag
      debugShowCheckedModeBanner: false,
      // Home
      home: new MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() {
    return new MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  var nameOfApp = "Persist Key Value";

  var counter = 0;

  // define a key to use later
  var key = "counter";

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0);
    });
  }

  _onIncrementHit() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0) + 1;
    });

    // Save Value
    prefs.setInt(key, counter);
  }

  _onDecrementHit() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0) - 1;
    });

    // Save Value
    prefs.setInt(key, counter);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Appbar
      appBar: new AppBar(
        // Title
        title: new Text(nameOfApp),
      ),
      // Body
      body: new Container(
        // Center the content
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                '$counter',
                textScaleFactor: 10.0,
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new RaisedButton(
                  onPressed: _onIncrementHit,
                  child: new Text('Increment Counter')),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new RaisedButton(
                  onPressed: _onDecrementHit,
                  child: new Text('Decrement Counter')),
            ],
          ),
        ),
      ),
    );
  }
}
