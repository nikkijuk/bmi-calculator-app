import 'dart:math';

import 'package:bmi_calculator_app/domain/bmi_calculator.dart';

// This bmi calculator supports traditional calculation
// with kilos and centimeters (iso)
// https://en.wikipedia.org/wiki/Body_mass_index
class TraditionalBmiCalculator extends BmiCalculator {

  // BMI = weight(kg)/height(m)^2 = 703*weight(lb)/height(in)^2.
  @override
  double calculateBmi (double height, double weight) {
    return height != 0 && weight != 0 ? ( weight / pow (height / 100, 2)) : 0;
  }

}
