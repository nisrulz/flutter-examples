import 'package:bmi_calculator/calculator/calculate_button.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/calculator/height_widget.dart';
import 'package:bmi_calculator/calculator/int_picker_widget.dart';
import 'package:bmi_calculator/calculator/sex_widget.dart';
import 'package:bmi_calculator/result/result_page.dart';
import 'package:bmi_calculator/body_model.dart';
import 'package:bmi_calculator/palette.dart';

class CalculatorBody extends StatefulWidget {
  const CalculatorBody({
    super.key,
    required this.model,
  });

  final BodyModel model;

  @override
  State<CalculatorBody> createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SexWidget(
                sex: widget.model.sex,
                onMaleTap: () => setState(() {
                      // Set sex to male
                      widget.model.sex = Sex.male;
                    }),
                onFemaleTap: () => setState(() {
                      // Set sex to female
                      widget.model.sex = Sex.female;
                    })),
            HeightWidget(
              height: widget.model.height,
              onHeightChanged: (height) => setState(() {
                // Set height and round to Int
                widget.model.height = height.toInt();
              }),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.width - 48) / 2,
              child: Row(
                children: [
                  Expanded(
                    // Weight widget
                    child: IntPickerWidget(
                      title: 'Weight',
                      onIncreaseTap: () => setState(() {
                        // Increase weight
                        widget.model.weight++;
                      }),
                      onDecreaseTap: () => setState(() {
                        // Decrease weight
                        widget.model.weight--;
                      }),
                      value: widget.model.weight,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    // Age widget
                    child: IntPickerWidget(
                      title: 'Age',
                      onIncreaseTap: () => setState(() {
                        // Increase age
                        widget.model.age++;
                      }),
                      onDecreaseTap: () => setState(() {
                        // Decrease age
                        widget.model.age--;
                      }),
                      value: widget.model.age,
                    ),
                  )
                ],
              ),
            ),
            CalculateButton(
              onTap: () {
                // Navigate to Result Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ResultPage(model: widget.model)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
