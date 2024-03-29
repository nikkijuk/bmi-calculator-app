
/// This bmi calculator supports calculation with kilos and centimeters (iso)
abstract class BmiCalculator  {

  // template method, does not need overriding
  double calculateBmiPrecision2 (double height, double weight) {
    return _round2(calculateBmi (height, weight));
  }

  // this method needs to be overridden
  double calculateBmi (double height, double weight);

  // helper method, private, can't be overridden
  // Dart math lib doesn't have arithmetic operations for rounding
  // to given amount of decimals, so one needs to have hack here
  // https://github.com/dart-lang/sdk/issues/8575
  // TODO: consider using Decimal datatype which is backed with BigInt
  double _round2 (double value) {
    return value != 0 ? ((value *100).roundToDouble())/100 : 0;
  }


}
