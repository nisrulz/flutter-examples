import 'package:flutter/material.dart';

import '../palette.dart';

class ResultContentWidget extends StatelessWidget {
  const ResultContentWidget({
    super.key,
    required this.result,
  });

  final double result;

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Column(
          children: [
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
    );
  }
}
