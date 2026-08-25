import 'package:flutter/material.dart';

class LoadingPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [CircularProgressIndicator()],
      ),
    );
  }
}
