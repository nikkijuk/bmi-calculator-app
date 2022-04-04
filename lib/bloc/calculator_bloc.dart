import 'package:bloc/bloc.dart';
import 'package:bmi_calculator_app/domain/bmi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  // set calculator and call super with initial state value
  CalculatorBloc(this.calculator) : super(CalculatorState.initial()) {

    // register event listeners
    on<CalculatorReset>((event, emit) => emit(CalculatorState.initial()));
    on<CalculatorHeightChanged>((event, emit) => emit(_createCalculatorState(event.height, state.weight)));
    on<CalculatorWeightChanged>((event, emit) => emit(_createCalculatorState(state.height, event.weight)));
  }

  BmiCalculator calculator;

  CalculatorState _createCalculatorState(double height, double weight) {
    var bmi = calculator.calculateBmiPrecision2 (height, weight);
    return CalculatorState (height: height, weight: weight, bmi: bmi);
  }

}
