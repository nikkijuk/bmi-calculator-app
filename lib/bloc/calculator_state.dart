part of 'calculator_bloc.dart';

// calculator state is immutable - if it changes new state object is created
@immutable
class CalculatorState extends Equatable {
  const CalculatorState({
    required this.height,
    required this.weight,
    required this.bmi,
  });

  const CalculatorState.initial()
      : this(
    height: 0,
    weight: 0,
    bmi: 0,
  );

  final double height;
  final double weight;
  final double bmi;

  bool get isComplete => height != 0 && weight != 0 && bmi != 0;

  @override
  List<Object> get props => [height, weight, bmi];
}
