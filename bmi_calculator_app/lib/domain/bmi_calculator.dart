import 'dart:math';

/**
 * This bmi calculator supports calculation with kilos and centimeters (iso)
 *
 * https://en.wikipedia.org/wiki/Body_mass_index
 */
class BmiCalculator  {

  static double calculateBmiPrecision2 (double height, double weight) {
    return _round2(BmiCalculator.calculateBmi (height, weight));
  }

  // note: null handling is not very nice, so it might need to be enhanced
  static double calculateBmi (double height, double weight) {
    return height != null && weight != null ? ( weight / pow (height / 100, 2)) : null;
  }

  // Dart math lib doesn't have arithmetic operations for rounding to given amount of decimals, so one needs to have hack here
  // https://github.com/dart-lang/sdk/issues/8575
  // note: null handling is not very nice, so it might need to be enhanced
  static double _round2 (double value) {
    return value != null ? ((value *100).roundToDouble())/100 : null;
  }

}
