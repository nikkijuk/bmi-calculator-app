part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent  {
  const CalculatorEvent();
}

class CalculatorReset extends CalculatorEvent {}

// mixin used as calculator event is base class and
// Dart doesn't support multi-inheritance
class CalculatorHeightChanged extends CalculatorEvent with EquatableMixin {
  const CalculatorHeightChanged({@required this.height}) : assert (height != null);

  final double height;

  @override
  List<Object> get props => [height];
}

// mixin used as calculator event is base class and
// Dart doesn't support multi-inheritance
class CalculatorWeightChanged extends CalculatorEvent with EquatableMixin {
  const CalculatorWeightChanged({@required this.weight}) : assert (weight != null);

  final double weight;

  @override
  List<Object> get props => [weight];

}



