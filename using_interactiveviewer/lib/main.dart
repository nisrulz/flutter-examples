import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Using InteractiveViewer"),
        ),
        body: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(100.0),
          minScale: 0.1,
          maxScale: 1.6,
          child: Center(
            child: FlutterLogo(
              size: 90,
            ),
          ),
        ),
      ),
    );
  }
}
