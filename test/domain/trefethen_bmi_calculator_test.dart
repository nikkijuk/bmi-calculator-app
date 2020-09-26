import 'package:bmi_calculator_app/domain/Trefethen_bmi_calculator.dart';
import 'package:test/test.dart';

// most boring unit test ever - check here how to write more
// https://flutter.dev/docs/cookbook/testing/unit/introduction
void main() {

  group('Rounded calculation', () {

    test('bmi should be calculated and rounded', () {
      var bmi = TrefethenBmiCalculator().calculateBmiPrecision2(170, 70);
      expect(bmi, 24.15);
    });

    test('bmi should not be calculated and rounded as weight is null', () {
      var bmi = TrefethenBmiCalculator().calculateBmiPrecision2(170, null);
      expect(bmi, null);
    });

    test('bmi should not be calculated and rounded as height is null', () {
      var bmi = TrefethenBmiCalculator().calculateBmiPrecision2(null, 70);
      expect(bmi, null);
    });

    test('bmi should not be calculated and rounded as params are null', () {
      var bmi = TrefethenBmiCalculator().calculateBmiPrecision2(null, null);
      expect(bmi, null);
    });

  });

  group('Calculation without rounding', () {

    test('bmi should be calculated', () {
      var bmi = TrefethenBmiCalculator().calculateBmi(170, 70);
      expect(bmi, 24.15010864536703);
    });

    test('bmi should not be calculated as weight is null', () {
      var bmi = TrefethenBmiCalculator().calculateBmi(170, null);
      expect(bmi, null);
    });

    test('bmi should not be calculated as height is null', () {
      var bmi = TrefethenBmiCalculator().calculateBmi(null, 70);
      expect(bmi, null);
    });

    test('bmi should not be calculated as params are null', () {
      var bmi = TrefethenBmiCalculator().calculateBmi(null, null);
      expect(bmi, null);
    });
  });

}
