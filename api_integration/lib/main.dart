import 'package:flutter/material.dart';
import 'package:apiintegration/api_call.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String timeNow = 'fetching\ntime...';

  void printTime() async {
    Time t = Time();
    await t.setupTime();
    setState(() {
      timeNow = t.time;
    });
  }

  @override
  void initState() {
    super.initState();
    printTime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Integrating API'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$timeNow',
                  style: TextStyle(fontSize: 70, color: Colors.blue),
                ),
                SizedBox(
                  height: 100,
                ),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        printTime();
                      });
                    },
                    color: Colors.black12,
                    child: Text(
                      'REFRESH',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
