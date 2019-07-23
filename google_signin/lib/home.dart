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
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                showLoading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        onPressed: this.onSignin,
                        child: Text("Sign In"),
                        color: Colors.lightBlueAccent,
                      ),
                //RaisedButton(onPressed: this.onLogout, child: Text("Logout"), color: Colors.amberAccent),
              ],
            ),
          )),
    );
  }
}
