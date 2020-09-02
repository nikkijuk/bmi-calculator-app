import 'package:bmi_calculator_app/domain/bmi_calculator.dart';
import 'package:test/test.dart';

void main() {
  test('bmi should be calculated', () {
   double bmi = BmiCalculator.calculateBmi(170, 70);
    expect(bmi, 24.221453287197235); // TODO: rounding would be nice :)
  });
}
