import 'dart:math';

import 'package:bmi_calculator/body_model.dart';

// I've used weight/height^2 (kg/m^2)
// You can expand this logic
double calculateBMI({required BodyModel bodyModel}) {
  return (bodyModel.weight) / pow(bodyModel.height / 100, 2);
}
