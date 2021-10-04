import 'package:flutter/material.dart';
import 'package:stateless_bottom_navi/Providers/screenIndexProvider.dart';
import 'Screens/homescreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
      providers: [
        ChangeNotifierProvider(create: (context) => screenIndexProvider())
      ],
    );
  }
}
