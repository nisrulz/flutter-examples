import 'package:bmi_calculator/body_model.dart';
import 'package:bmi_calculator/palette.dart';
import 'package:flutter/material.dart';

import 'bmi_calculator.dart';

class ResultPage extends StatelessWidget {
  final BodyModel model;

  const ResultPage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final result = calculateBMI(bodyModel: model);

    Color resultColor() {
      if (result < 18.5) {
        return Palette.underweightResult;
      } else if (result > 25) {
        return Palette.overWeightResult;
      } else {
        return Palette.normalResult;
      }
    }

    String diagnosis() {
      if (result < 18.5) {
        return 'UNDERWEIGHT';
      } else if (result > 25) {
        return 'OVERWEIGHT';
      } else {
        return 'NORMAL';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('RESULT'),
        backgroundColor: Palette.background,
        leading: IconButton(
          onPressed: () {
            // Navigate back to previous page
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        color: Palette.background,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(72.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                diagnosis(),
                style: TextStyle(
                  color: resultColor(),
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              Text(
                // [toStringAsFixed] for decimal-point string-representation
                result.toStringAsFixed(1),
                style: const TextStyle(
                  color: Palette.textActive,
                  fontWeight: FontWeight.w600,
                  fontSize: 100,
                ),
              ),
              Column(
                children: const [
                  Text(
                    'Normal BMI range:',
                    style: TextStyle(
                      color: Palette.textInactive,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '18.5 - 25 kg/m2',
                    style: TextStyle(
                      color: Palette.textActive,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
