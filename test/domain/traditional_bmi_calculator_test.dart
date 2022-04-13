import 'package:bmi_calculator_app/domain/traditional_bmi_calculator.dart';
import 'package:test/test.dart';

// most boring unit test ever - check here how to write more
// https://flutter.dev/docs/cookbook/testing/unit/introduction
void main() {

  group('Rounded calculation', () {

    test('bmi should be calculated and rounded', () {
      final bmi = TraditionalBmiCalculator().calculateBmiPrecision2(170, 70);
      expect(bmi, 24.22);
    });

    test('bmi should not be calculated and rounded as weight is null', () {
      final bmi = TraditionalBmiCalculator().calculateBmiPrecision2(170, 0);
      expect(bmi, null);
    });

    test('bmi should not be calculated and rounded as height is null', () {
      final bmi = TraditionalBmiCalculator().calculateBmiPrecision2(0, 70);
      expect(bmi, null);
    });

    test('bmi should not be calculated and rounded as params are null', () {
      final bmi = TraditionalBmiCalculator().calculateBmiPrecision2(0, 0);
      expect(bmi, null);
    });

  });

  group('Calculation without rounding', () {

    test('bmi should be calculated', () {
      final bmi = TraditionalBmiCalculator().calculateBmi(170, 70);
      expect(bmi, 24.221453287197235);
    });

    test('bmi should not be calculated as weight is null', () {
      final bmi = TraditionalBmiCalculator().calculateBmi(170, 0);
      expect(bmi, null);
    });

    test('bmi should not be calculated as height is null', () {
      final bmi = TraditionalBmiCalculator().calculateBmi(0, 70);
      expect(bmi, null);
    });

    test('bmi should not be calculated as params are null', () {
      final bmi = TraditionalBmiCalculator().calculateBmi(0, 0);
      expect(bmi, null);
    });
  });

}
