import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

// test calculator blocs initial state and sending events using sink / receiving state as responses from stream
// https://pub.dev/packages/bloc_test
void main() {
  group('CalculatorBloc', () {
    test('initial state is not complete', () {
      expect(CalculatorBloc().state.isComplete, false);
    });

    test('initial state of height is null', () {
      expect(CalculatorBloc().state.height, null);
    });

    test('initial state of qeight is null', () {
      expect(CalculatorBloc().state.weight, null);
    });

    test('initial state of bmi is null', () {
      expect(CalculatorBloc().state.bmi, null);
    });

    group('calculate', () {
      blocTest<CalculatorBloc, CalculatorState>(
        'to events created in response to set height und weight',
        build: () => CalculatorBloc(),
        act: (bloc) => bloc
          ..add(CalculatorHeightChanged(height: 170))
          ..add(CalculatorWeightChanged(weight: 70)),
        expect: const <CalculatorState>[
          CalculatorState(height: 170, weight: null, bmi: null),
          CalculatorState(height: 170, weight: 70, bmi: 24.22)
        ],
      );

      // TODO: add test for reset ?

    });
  });
}