import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soap_application/MainScreen.dart';

import 'Add Member Data Show.dart';
import 'feedback_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MediaQuery(data: MediaQueryData(),
      child:MaterialApp( debugShowCheckedModeBanner: false,
        home: CupertinoPageScaffold(
      child: ShowMemberDetails(),
    ),));

  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const ShowMemberDetails();
  }
}

