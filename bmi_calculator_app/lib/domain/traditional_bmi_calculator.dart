import 'dart:math';

import 'package:bmi_calculator_app/domain/bmi_calculator.dart';

/**
 * This bmi calculator supports traditional calculation with kilos and centimeters (iso)
 *
 * https://en.wikipedia.org/wiki/Body_mass_index
 */
class TraditionalBmiCalculator extends BmiCalculator {

  // Current formula: BMI = weight(kg)/height(m)^2 = 703*weight(lb)/height(in)^2.
  double calculateBmi (double height, double weight) {
    return height != null && weight != null ? ( weight / pow (height / 100, 2)) : null;
  }

}
