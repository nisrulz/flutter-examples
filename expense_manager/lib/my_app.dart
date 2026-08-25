import 'package:expense_manager/constants.dart';
import 'package:expense_manager/misc/custom_theme_data.dart';
import 'package:expense_manager/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final Widget initialPage;

  const MyApp({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppName,
      theme: CustomThemeData().theme,
      darkTheme: CustomThemeData().darkTheme,
      home: MainPage(),
    );
  }
}
