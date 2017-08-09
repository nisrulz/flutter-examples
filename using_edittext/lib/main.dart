import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyEditText(),
  ));
}

class MyEditText extends StatefulWidget {
  @override
  MyEditTextState createState() => new MyEditTextState();
}

class MyEditTextState extends State<MyEditText> {
  String results = "";

  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Using EditText"),
        backgroundColor: Colors.red,
      ),
      body: new Container(
        padding: const EdgeInsets.all(10.0),
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(hintText: "Enter text here..."),
                onSubmitted: (String str) {
                  setState(() {
                    results = results + "\n" + str;
                    controller.text = "";
                  });
                },
                controller: controller,
              ),
              new Text(results)
            ],
          ),
        ),
      ),
    );
  }
}
