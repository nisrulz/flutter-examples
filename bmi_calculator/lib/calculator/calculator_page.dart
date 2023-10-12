import 'package:bmi_calculator/calculator/calculator_body.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/body_model.dart';
import 'package:bmi_calculator/palette.dart';

class CalculatorPage extends StatelessWidget {
  CalculatorPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  final BodyModel model = BodyModel(
    sex: Sex.male,
    height: 183,
    weight: 74,
    age: 19,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Palette.background,
      ),
      body: CalculatorBody(model: model),
    );
  }
}
