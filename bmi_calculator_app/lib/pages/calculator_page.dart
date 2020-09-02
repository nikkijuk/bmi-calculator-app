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
          initialValue: state.height.toString(),
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Height',
            //errorText: state.height.invalid ? 'Invalid Email' : null,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            double height = double.parse(value);
            print(height);
            context.bloc<CalculatorBloc>().add(CalculatorHeightChanged(height: height));
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
          initialValue: state.weight.toString(),
          decoration: InputDecoration(
            icon: const Icon(Icons.party_mode),
            labelText: 'Weight',
            //errorText: state.weight.invalid ? 'Invalid Email' : null,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            double weight = double.parse(value);
            print(weight);
            context.bloc<CalculatorBloc>().add(CalculatorWeightChanged(weight: weight));
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
      buildWhen: (previous, current)  {
        print ('bmi ${current.bmi}');
        return previous.bmi != current.bmi;
      },
      builder: (context, state) {
        return Text(state.bmi.toString(),
        );
      },
    );
  }
}