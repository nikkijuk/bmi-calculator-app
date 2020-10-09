import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bmi_calculator_app/domain/bmi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc(this.calculator) : super(const CalculatorState.initial());

  BmiCalculator calculator;

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {

    switch (event.runtimeType) {
      case CalculatorReset:
        yield const CalculatorState.initial();
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
    yield _createCalculatorState(event?.height, state?.weight);
  }

  Stream<CalculatorState> _changeWeight(CalculatorWeightChanged event) async* {
    yield _createCalculatorState(state?.height, event?.weight);
  }

  CalculatorState _createCalculatorState(double height, double weight) {
    var bmi = calculator.calculateBmiPrecision2 (height, weight);
    return CalculatorState (height: height, weight: weight, bmi: bmi);
  }

}
