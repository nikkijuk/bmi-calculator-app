part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {
  const CalculatorEvent();
}

class CalculatorReset extends CalculatorEvent {}

class CalculatorHeightChanged extends CalculatorEvent {
  const CalculatorHeightChanged({this.height});

  final double height;
}

class CalculatorWeightChanged extends CalculatorEvent {
  const CalculatorWeightChanged({this.weight});

  final double weight;
}



