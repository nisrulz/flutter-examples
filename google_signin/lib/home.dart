import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Home extends StatelessWidget {
  Home(
      {Key key,
      @required this.onSignin,
      @required this.onLogout,
      @required this.showLoading})
      : super(key: key);

  final VoidCallback onSignin;
  final VoidCallback onLogout;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Sign In")),
      body: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                showLoading
                    ? new CircularProgressIndicator()
                    : new RaisedButton(
                        onPressed: this.onSignin,
                        child: new Text("Sign In"),
                        color: Colors.lightBlueAccent,
                      ),
                //new RaisedButton(onPressed: this.onLogout, child: new Text("Logout"), color: Colors.amberAccent),
              ],
            ),
          )),
    );
  }
}
