import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator_app/domain/bmi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  CalculatorBloc() : super(CalculatorState.initial());

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    if (event is CalculatorReset) {
      yield CalculatorState.initial();
    } else if (event is CalculatorHeightChanged) {
      yield* _setHeight(event.height);
    } else if (event is CalculatorWeightChanged) {
      yield* _setWeight(event.weight);
    }
  }

  Stream<CalculatorState> _setHeight(double height) async* {
    yield _calculate(height, state.weight);
  }
  Stream<CalculatorState> _setWeight(double weight) async* {
    yield _calculate(state.height, weight);
  }

  CalculatorState _calculate(double height, double weight) {
    double bmi = _round2(BmiCalculator.calculateBmi (height, weight));
    CalculatorState state = CalculatorState (height: height, weight: weight, bmi: bmi);
    return state;
  }

  // Dart math lib doesn't have arithmetic operations for rounding to given amount of decimals, so one needs to have hack here
  // https://github.com/dart-lang/sdk/issues/8575
  // note: null handling is not very nice, so it might need to be enhanced
  double _round2 (double value) {
    return value != null ? ((value *100).roundToDouble())/100 : null;
  }

}
