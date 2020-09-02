import 'package:bmi_calculator_app/domain/bmi_calculator.dart';
import 'package:test/test.dart';

// most boring unit test ever - check here how to write more
// https://flutter.dev/docs/cookbook/testing/unit/introduction
void main() {
  test('bmi should be calculated', () {
   double bmi = BmiCalculator.calculateBmi(170, 70);
    expect(bmi, 24.221453287197235); // TODO: rounding would be nice :)
  });

  test('bmi should not be calculated as weight is null', () {
    double bmi = BmiCalculator.calculateBmi(170, null);
    expect(bmi, null);
  });

  test('bmi should not be calculated as height is null', () {
    double bmi = BmiCalculator.calculateBmi(null, 70);
    expect(bmi, null);
  });

  test('bmi should not be calculated as params are null', () {
    double bmi = BmiCalculator.calculateBmi(null, null);
    expect(bmi, null);
  });

}
