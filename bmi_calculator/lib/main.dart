import 'package:bmi_calculator/calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Prevent landscape orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BMI Calculator',
      home: CalculatorPage(title: 'BMI CALCULATOR'),
    );
  }
}
