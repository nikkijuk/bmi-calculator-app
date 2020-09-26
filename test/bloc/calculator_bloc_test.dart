import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:bmi_calculator_app/domain/traditional_bmi_calculator.dart';
import 'package:bmi_calculator_app/domain/trefethen_bmi_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

// test calculator bloc initial state and sending events using sink / receiving state as responses from stream
// https://pub.dev/packages/bloc_test
void main() {
  group('CalculatorBloc', () {
    test('initial state is not complete', () {
      expect(CalculatorBloc(TraditionalBmiCalculator()).state.isComplete,
          false);
    });

    test('initial state of height is null', () {
      expect(CalculatorBloc(TraditionalBmiCalculator()).state.height, null);
    });

    test('initial state of weight is null', () {
      expect(CalculatorBloc(TraditionalBmiCalculator()).state.weight, null);
    });

    test('initial state of bmi is null', () {
      expect(CalculatorBloc(TraditionalBmiCalculator()).state.bmi, null);
    });

  });

  group('calculation of bmi with traditional algorithm', () {
    blocTest<CalculatorBloc, CalculatorState>(
      'to events created in response to set height und weight',
      build: () => CalculatorBloc(TraditionalBmiCalculator()),
      act: (bloc) => bloc
        ..add(const CalculatorHeightChanged(height: 170))
        ..add(const CalculatorWeightChanged(weight: 70)),
      expect: const <CalculatorState>[
        CalculatorState(height: 170, weight: null, bmi: null),
        CalculatorState(height: 170, weight: 70, bmi: 24.22)
      ],
    );
  });

  group('calculation of bmi with trefethen algorithm', () {
    blocTest<CalculatorBloc, CalculatorState>(
      'to events created in response to set height und weight',
      build: () => CalculatorBloc(TrefethenBmiCalculator()),
      act: (bloc) => bloc
        ..add(const CalculatorHeightChanged(height: 170))
        ..add(const CalculatorWeightChanged(weight: 70)),
      expect: const <CalculatorState>[
        CalculatorState(height: 170, weight: null, bmi: null),
        CalculatorState(height: 170, weight: 70, bmi: 24.15)
      ],
    );
  });
}