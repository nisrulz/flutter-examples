import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class User extends StatelessWidget {
  User({Key key, @required this.onLogout, @required this.user})
      : super(key: key);

  VoidCallback onLogout;
  String username;
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.exit_to_app), onPressed: this.onLogout)
        ],
      ),
      body: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Center(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.network(user.photoUrl),
              new Text(
                user.displayName,
                textScaleFactor: 1.5,
              ),
            ],
          ))),
    );
  }
}
