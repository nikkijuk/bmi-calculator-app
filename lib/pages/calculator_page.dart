import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:bmi_calculator_app/widgets/BmiCalculationResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CalculatorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Center (
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  HeightInput (),
                  WeightInput (),
                  BmiCalculationResult(),
                  //rResetButton(),
                ],
              )
            ),
          );
        },
      );
    }

}


class HeightInput extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // create callback handler, which
    // - uses BlocProvider to find CalculatorBloc using it's type
    // - creates CalculatorHeightChangedEvent and adds it to sink of CalculatorBloc
    void _onHeightChanged(String value) =>
        context.bloc<CalculatorBloc>().add(CalculatorHeightChanged(height: _parseDoubleOrNull(value)));

    // listens stream of CalculatorBloc, which
    // - triggers when new CalculatorState is received from stream
    // - building of widget happens when previous and current object differ in meaningful way
    // - builder return newly built widget if building has happened
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.height != current.height,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(8),
          child: TextFormField(
            key: ValueKey ("height"),
            initialValue: state.height?.toString() ?? '',
            decoration: InputDecoration(
              icon: const Icon(Icons.vertical_align_center),
              labelText: 'Height',
              hintText: 'Height in centimeters',
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8),
            ),
            keyboardType: TextInputType.number,
            onChanged: _onHeightChanged,
          ),
        );
      },
    );
  }
}

class WeightInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void _onWeightChanged(String value) =>
        context.bloc<CalculatorBloc>().add(CalculatorWeightChanged(weight: _parseDoubleOrNull(value)));

    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.weight != current.weight,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(8) ,
          child: TextFormField(
            key: ValueKey ("weight"),
            initialValue: state.weight?.toString() ?? '',
            decoration: InputDecoration(
              icon: const Icon(Icons.restaurant),
              labelText: 'Weight',
              hintText: 'Weight in kilograms',
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8),
            ),
            keyboardType: TextInputType.number,
            onChanged: _onWeightChanged,
          ),
        );
      },
    );
  }
}

// this was tricky: field can contain null, empty or numeric value
double _parseDoubleOrNull(String value) => value != null && value != '' ? double.parse(value) : null;

