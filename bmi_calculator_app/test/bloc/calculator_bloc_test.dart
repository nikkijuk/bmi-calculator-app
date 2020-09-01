import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

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
      /*
      blocTest<CalculatorBloc, CalculatorState>(
        'initial state is emitted',
        build: () => CalculatorBloc(),
        expect: const <CalculatorState>[
          CalculatorState(height: null, weight: null, bmi: null),
        ],
      );
  */

      blocTest<CalculatorBloc, CalculatorState>(
        'to events created in response to set height und weight',
        build: () => CalculatorBloc(),
        act: (bloc) => bloc
          ..add(CalculatorHeightChanged(height: 170))
          ..add(CalculatorWeightChanged(weight: 70)),
        expect: const <CalculatorState>[
          //CalculatorState(height: null, weight: null, bmi: null),
          CalculatorState(height: 170, weight: null, bmi: null),
          CalculatorState(height: 170, weight: 70, bmi: 0)
        ],
      );

      /*
      blocTest<CounterCubit, int>(
        'emits [1, 2] when state is 0 and invoked twice',
        build: () => CounterCubit(),
        act: (cubit) => cubit..increment()..increment(),
        expect: const <int>[1, 2],
      );

      blocTest<CounterCubit, int>(
        'emits [42] when state is 41',
        build: () => CounterCubit()..emit(41),
        act: (cubit) => cubit.increment(),
        expect: const <int>[42],
      );
       */

    });
  });
}