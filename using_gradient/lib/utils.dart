import 'package:flutter/material.dart';

LinearGradient getCustomGradient() {
  // Define a Linear Gradient
  return LinearGradient(
      colors: [Colors.pink, Colors.blueAccent],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(0.6, 0.0),
      stops: [0.0, 0.6],
      tileMode: TileMode.clamp);
}
