part of 'calculator_bloc.dart';

// calculator state is immutable - if it changes new state object is created
@immutable
class CalculatorState extends Equatable {
  const CalculatorState({
    @required this.height,
    @required this.weight,
    @required this.bmi,
  });

  const CalculatorState.initial()
      : this(
    height: null,
    weight: null,
    bmi: null,
  );

  final double height;
  final double weight;
  final double bmi;

  CalculatorState copyWith({
    int height,
    int weight,
    int bmi,
  }) {
    return CalculatorState(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
    );
  }

  bool get isComplete => height != null && weight != null && bmi != null;

  @override
  List<Object> get props => [height, weight, bmi];
}
