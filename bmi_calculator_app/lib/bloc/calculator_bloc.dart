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
      yield* _changeHeight(event.height);
    } else if (event is CalculatorWeightChanged) {
      yield* _changeWeight(event.weight);
    }
  }

  Stream<CalculatorState> _changeHeight(double height) async* {
    yield _createCalculatorState(height, state.weight);
  }
  Stream<CalculatorState> _changeWeight(double weight) async* {
    yield _createCalculatorState(state.height, weight);
  }

  CalculatorState _createCalculatorState(double height, double weight) {
    double bmi = BmiCalculator.calculateBmiPrecision2 (height, weight);
    return CalculatorState (height: height, weight: weight, bmi: bmi);
  }

}
