import 'package:expense_manager/pages/main_page.dart';
import 'package:expense_manager/services/app_init_service.dart';
import 'package:flutter/material.dart';
import 'my_app.dart';

Future<void> main() async {
  await AppInitService.init();
  runApp(MyApp(initialPage: MainPage()));
}
