import 'dart:math';

import 'package:bmi_calculator_app/domain/bmi_calculator.dart';

/// This is new bmi calculator which supports calculation
/// with kilos and centimeters (iso)
/// https://people.maths.ox.ac.uk/trefethen/bmi.html
class TrefethenBmiCalculator extends BmiCalculator {

  // BMI = 1.3*weight(kg)/height(m)^2.5 = 5734*weight(lb)/height(in)^2.5
  @override
  double calculateBmi (double height, double weight) {
    return height != null && weight != null
        ? ( 1.3 * weight / pow (height / 100, 2.5)) : null;
  }

}
