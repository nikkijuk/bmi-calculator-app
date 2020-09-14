import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;


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

class BmiCalculationResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.bmi != current.bmi,
      builder: (context, state) {
        return state.bmi == null ?
          Center(
            child: Text(
                "not calculated",
                key: ValueKey ("not-calculated"),
            ),
          )
        :
          Container(
            height: MediaQuery.of(context).size.height * 30/100,
            width:MediaQuery.of(context).size.width * 60/100,
            child: Column(
              children: [
                Text(
                  "Bmi is ${state.bmi}",
                  key: ValueKey ("bmi"),
                  style: Theme.of(context).textTheme.headline4,
                ),

                Expanded(
                  child: charts.BarChart (
                    _nutritionalStatuses(),
                    animate: false,
                    barGroupingType: charts.BarGroupingType.stacked,
                    vertical: false,
                  ),
                ),
              ],
            ),
          );
      },
    );
  }

}

// this was tricky: field can contain null, empty or numeric value
double _parseDoubleOrNull(String value) => value != null && value != '' ? double.parse(value) : null;


/// Create series list with multiple series
List<charts.Series<NutritionalStatus, String>> _nutritionalStatuses() {
  final statuses = [
    NutritionalStatus ('U', 'Underweight', 0, 18.5, Colors.red.shade50),
    NutritionalStatus ('N', 'Normal weight', 18.5, 25, Colors.green),
    NutritionalStatus ('PO', 'Pre-obesity', 25.0, 30, Colors.red.shade50),
    NutritionalStatus ('O1', 'Obesity class I', 30.0, 35, Colors.red.shade100),
    NutritionalStatus ('O2', 'Obesity class II', 35.0, 40, Colors.red.shade200),
    NutritionalStatus ('O3', 'Obesity class III', 40.0, 100, Colors.red.shade400),
  ];


  return [
    new charts.Series<NutritionalStatus, String>(
      id: 'BMI',
      domainFn: (NutritionalStatus status, _) => "BMI",
      measureFn: (NutritionalStatus status, _) => status.maxBmi - status.minBmi,
      colorFn: (NutritionalStatus status, _) => charts.Color(r: status.color.red, g: status.color.green, b: status.color.blue),
      data: statuses,
    )
  ];
}

// https://www.euro.who.int/en/health-topics/disease-prevention/nutrition/a-healthy-lifestyle/body-mass-index-bmi

class NutritionalStatus {
  final String id;
  final String name;
  final double minBmi;
  final double maxBmi;
  final Color color;

  NutritionalStatus(this.id, this.name, this.minBmi, this.maxBmi, this.color);
}