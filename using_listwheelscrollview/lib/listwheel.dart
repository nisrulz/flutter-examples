import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'roundcontainer.dart';

class Listwheel extends StatefulWidget {
  @override
  _ListwheelState createState() => _ListwheelState();
}

class _ListwheelState extends State<Listwheel> {
  double size = 28;
  int radius = 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        child: ListWheelScrollView(
          children: [
            NewWidget(
                size: size,
                l: Icon(
                  Icons.brush,
                  color: Colors.white54,
                  size: size,
                ),
                s: 'Brush'),
            NewWidget(
                size: size,
                l: Icon(
                  Icons.style,
                  color: Colors.white54,
                  size: size,
                ),
                s: 'Style'),
            NewWidget(
                size: size,
                l: Icon(
                  Icons.build,
                  color: Colors.white54,
                  size: size,
                ),
                s: 'Build'),
            NewWidget(
                size: size,
                l: Icon(
                  Icons.add,
                  color: Colors.white54,
                  size: size,
                ),
                s: 'Add'),
            NewWidget(
                size: size,
                l: Icon(
                  Icons.delete,
                  color: Colors.white54,
                  size: size,
                ),
                s: 'Delete'),
            NewWidget(
                size: size,
                l: Icon(
                  Icons.details,
                  color: Colors.white54,
                  size: size,
                ),
                s: 'Details'),
            NewWidget(
                size: size,
                l: Icon(
                  Icons.email,
                  color: Colors.white54,
                  size: size,
                ),
                s: 'Email'),
          ],
          squeeze: 1.0,
          itemExtent: 180,
          diameterRatio: 1.9,
          offAxisFraction: -0.5,
        ),
      ),
    );
  }
}
