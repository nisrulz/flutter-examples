import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ContactPage(), debugShowCheckedModeBanner: false,));
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Using SnackBar"),
      ),
      body: Center(
        child: MyButton(),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Show SnackBar'),
      // On pressing the raised button
      onPressed: () {
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              // set content of snackbar
              content: Text("Hello! I am SnackBar :)"),
              // set duration
              duration: Duration(seconds: 3),
              // set the action
              action: SnackBarAction(
                  label: "Hit Me (Action)",
                  onPressed: () {
                    // When action button is pressed, show another snackbar
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Hello! I am shown becoz you pressed Action :)"),
                        ));
                  }),
            ));
      },
    );
  }
}
