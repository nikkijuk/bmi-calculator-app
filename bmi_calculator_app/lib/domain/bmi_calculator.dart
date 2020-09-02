import 'dart:math';

class BmiCalculator  {

  static double calculateBmi (int height, int weight) {
    //  = num.parse(n.toStringAsFixed(2));
    //double result = height != null && weight != null ? double.parse(((weight / pow(height, 2)) * 703).toStringAsPrecision(0)) : null;
    //double result = height != null && weight != null ? ((weight / pow(height, 2)) * 703).truncateToDouble() : null;
    double bmi = height != null && weight != null ? 42 : null;
    return bmi;
  }

}
