import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator_app/domain/bmi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  BmiCalculator calculator;

  CalculatorBloc(this.calculator) : super(CalculatorState.initial());

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {

    switch (event.runtimeType) {
      case CalculatorReset:
        yield CalculatorState.initial();
        break;
      case CalculatorHeightChanged:
        yield* _changeHeight(event);
        break;
      case CalculatorWeightChanged:
        yield* _changeWeight(event);
        break;
    }
  }

  Stream<CalculatorState> _changeHeight(CalculatorHeightChanged event) async* {
    double height = event.height;
    yield _createCalculatorState(height, state.weight);
  }

  Stream<CalculatorState> _changeWeight(CalculatorWeightChanged event) async* {
    double weight = event.weight;
    yield _createCalculatorState(state.height, weight);
  }

  CalculatorState _createCalculatorState(double height, double weight) {
    double bmi = calculator.calculateBmiPrecision2 (height, weight);
    return CalculatorState (height: height, weight: weight, bmi: bmi);
  }

}
