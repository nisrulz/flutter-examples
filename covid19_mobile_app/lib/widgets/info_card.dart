import 'package:flutter/material.dart';

// this is the rounded rectangle card widget that appears on the homescreen
Widget infoCard(BuildContext context, String title, String number) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
    color: Color(0xfff44e3f),
  );
}
