import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

      return BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              HeightInput (),
              WeightInput (),
              BmiField(),
            ],
          );
        },
      );
    }
}

class HeightInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.height != current.height,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.height?.toString() ?? '',
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Height',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            context.bloc<CalculatorBloc>().add(CalculatorHeightChanged(height: _parseDoubleOrNull(value)));
          },
        );
      },
    );
  }
}

class WeightInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.weight != current.weight,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.weight?.toString() ?? '',
          decoration: InputDecoration(
            icon: const Icon(Icons.party_mode),
            labelText: 'Weight',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            context.bloc<CalculatorBloc>().add(CalculatorWeightChanged(weight: _parseDoubleOrNull(value)));
          },
        );
      },
    );
  }
}

class BmiField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.bmi != current.bmi,
      builder: (context, state) {
        return Text(
          "Bmi is ${state.bmi?.toString() ?? '<not calculated yet>'}",
        );
      },
    );
  }
}

// this was tricky: field can contain null, empty or numeric value
double _parseDoubleOrNull(String value) => value != null && value != '' ? double.parse(value) : null;
