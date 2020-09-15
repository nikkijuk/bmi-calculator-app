import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';

// Complexity of this single component and it's dependencies are reason
// why it has been moved to separate file - there's no need to reuse it
class BmiCalculationResult extends StatelessWidget {

  /// For data see:
  /// - https://www.euro.who.int/en/health-topics/disease-prevention/nutrition/a-healthy-lifestyle/body-mass-index-bmi
  // - https://www.calculator.net/bmi-calculator.html
  /*
    Severe Thinness	< 16
    Moderate Thinness	16 - 17
    Mild Thinness	17 - 18.5
    Normal	18.5 - 25
    Overweight	25 - 30
    Obese Class I	30 - 35
    Obese Class II	35 - 40
    Obese Class III	> 40
    */

  // it might be wise to put this data later on to own file - now it's here locally since we only need it here
  // NOTE: Colors are from dart.ui package - they are not same colors as chart component uses
  final statuses = [
    NutritionalStatus ('T3', 'Severe Thinness', 0, 16, Colors.blue),
    NutritionalStatus ('T2', 'Moderate Thinness', 16, 17, Colors.blue.shade100),
    NutritionalStatus ('T1', 'Mild Thinness', 17, 18.5, Colors.blue.shade200),
    NutritionalStatus ('N',  'Normal weight', 18.5, 25, Colors.green),
    NutritionalStatus ('PO', 'Overweight', 25.0, 30, Colors.orange),
    NutritionalStatus ('O1', 'Obese class I', 30.0, 35, Colors.red.shade200),
    NutritionalStatus ('O2', 'Obese class II', 35.0, 40, Colors.red.shade100),
    NutritionalStatus ('O3', 'Obese class III', 40.0, 100, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.bmi != current.bmi,
      builder: (context, state) {
        if (state.bmi == null) {
          return Center(
          child: Text(
            "not calculated",
            key: ValueKey ("not-calculated"),
          ),
        );
        } else {
          NutritionalStatus current = statuses.lastWhere((element) => element.minBmi <= state.bmi);
          return Container(
          height: MediaQuery.of(context).size.height * 30/100,
          width:MediaQuery.of(context).size.width * 60/100,
          child: Column(
            children: [
              Text(
                "Bmi is ${state.bmi}",
                key: ValueKey ("bmi"),
                style: Theme.of(context).textTheme.headline4.apply(color: current.color),
              ),
              Text(
                current.name,
                key: ValueKey ("bmi-name"),
                style: Theme.of(context).textTheme.headline6.apply(color: current.color),
              ),
              Expanded(
                child: charts.BarChart (
                    _nutritionalStatuses(state.bmi),
                    animate: false,
                    barGroupingType: charts.BarGroupingType.stacked,
                    vertical: false,
                    customSeriesRenderers: [
                      new charts.BarTargetLineRendererConfig<String>(
                        // ID used to link series to this renderer.
                          customRendererId: 'bmiResultLine',
                          groupingType: charts.BarGroupingType.stacked)
                    ]
                ),
              ),
            ],
          ),
        );
        }
      },
    );
  }


  /// Create series list with multiple series
  List<charts.Series<NutritionalStatus, String>> _nutritionalStatuses(double bmi) {


    final result = [
      NutritionalStatus ('ME', 'My BMI', bmi, bmi, Colors.black),
    ];

    return [
      new charts.Series<NutritionalStatus, String>(
        id: 'BMI Scale',
        domainFn: (NutritionalStatus status, _) => "BMI",
        measureFn: (NutritionalStatus status, _) => status.maxBmi - status.minBmi,
        // NOTE: Colors which charts uses are from charts_flutter package - one needs to have manual conversion fo dart.ui colors
        colorFn: (NutritionalStatus status, _) => charts.Color(r: status.color.red, g: status.color.green, b: status.color.blue),
        data: statuses,
      ),
      new charts.Series<NutritionalStatus, String>(
        id: 'BMI Result',
        domainFn: (NutritionalStatus status, _) => "BMI",
        measureFn: (NutritionalStatus status, _) => status.minBmi,
        strokeWidthPxFn: (NutritionalStatus status, _) => 6,
        data: result,
      )
      // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'bmiResultLine'),
    ];
  }
}

class NutritionalStatus {
  final String id;
  final String name;
  final double minBmi;
  final double maxBmi;
  final Color color;

  NutritionalStatus(this.id, this.name, this.minBmi, this.maxBmi, this.color);
}
