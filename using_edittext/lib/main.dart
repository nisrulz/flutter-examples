import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyEditText(),
  ));
}

class MyEditText extends StatefulWidget {
  @override
  MyEditTextState createState() => MyEditTextState();
}

class MyEditTextState extends State<MyEditText> {
  String results = "";

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Using EditText"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Enter text here..."),
                onSubmitted: (String str) {
                  setState(() {
                    results = results + "\n" + str;
                    controller.text = "";
                  });
                },
                controller: controller,
              ),
              Text(results)
            ],
          ),
        ),
      ),
    );
  }
}
