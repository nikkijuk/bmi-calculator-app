part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {
  const CalculatorEvent();
}

class CalculatorReset extends CalculatorEvent {}

class CalculatorHeightChanged extends CalculatorEvent {
  const CalculatorHeightChanged({this.height});

  final int height;
}

// sorry: we use integers: if one is 69.5 kg it's 69 or 70, nothing between
class CalculatorWeightChanged extends CalculatorEvent {
  const CalculatorWeightChanged({this.weight});

  final int weight;
}



