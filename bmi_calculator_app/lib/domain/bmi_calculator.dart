import 'dart:math';

/**
 * This bmi calculator supports calculation with kilos and centimeters (iso)
 *
 * https://en.wikipedia.org/wiki/Body_mass_index
 */
class BmiCalculator  {

  // note: null handling is not very nice, so it might need to be enhanced
  static double calculateBmi (double height, double weight) {
    double bmi = height != null && weight != null ? ( weight / pow (height / 100, 2)) : null;
    print(bmi);
    return bmi;
  }

}
