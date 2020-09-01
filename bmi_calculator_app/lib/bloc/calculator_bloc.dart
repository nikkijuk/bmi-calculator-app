import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
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

  Stream<CalculatorState> _setHeight(int height) async* {
    yield _calculate(height, state.weight);
  }
  Stream<CalculatorState> _setWeight(int weight) async* {
    yield _calculate(state.height, weight);
  }

  CalculatorState _calculate(int height, int weight) {
    //  = num.parse(n.toStringAsFixed(2));
    //double result = height != null && weight != null ? double.parse(((weight / pow(height, 2)) * 703).toStringAsPrecision(0)) : null;
    //double result = height != null && weight != null ? ((weight / pow(height, 2)) * 703).truncateToDouble() : null;
    double result = height != null && weight != null ? 0 : null;
    CalculatorState state = CalculatorState (height: height, weight: weight, bmi: result);
    print (state);
    return state;
  }

}
