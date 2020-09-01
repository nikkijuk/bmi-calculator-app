part of 'calculator_bloc.dart';

class CalculatorState {
  const CalculatorState({
    @required this.height,
    @required this.weight,
    @required this.bmi,
  });

  final int height;
  final int weight;
  final double bmi;

  bool get isComplete => height != null && weight != null && bmi != null;

  const CalculatorState.initial()
      : this(
    height: null,
    weight: null,
    bmi: null,
  );

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

  bool operator ==(Object other) => other is CalculatorState && height == other.height && weight == other.weight && bmi == other.bmi;

}
