import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:bmi_calculator_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';

// Complexity of this single component and it's dependencies are reason
// why it has been moved to separate file - there's no need to reuse it
class BmiCalculationResult extends StatelessWidget {

  /*
  Classification:
    Severe Thinness	< 16
    Moderate Thinness	16 - 17
    Mild Thinness	17 - 18.5
    Normal	18.5 - 25
    Overweight	25 - 30
    Obese Class I	30 - 35
    Obese Class II	35 - 40
    Obese Class III	> 40
  */

  // it might be wise to put this data later on to own file
  // now it's here locally since we only need it here
  // NOTE: Colors are from dart.ui package,
  // they are not same colors as chart component uses
  final statuses = [
    NutritionalStatus ('t3', 'Severe Thinness', 0, 16, Colors.blue),
    NutritionalStatus ('t2', 'Moderate Thinness', 16, 17, Colors.blue.shade300),
    NutritionalStatus ('t1', 'Mild Thinness', 17, 18.5, Colors.blue.shade100),
    NutritionalStatus ('n',  'Normal weight', 18.5, 25, Colors.green),
    NutritionalStatus ('po', 'Overweight', 25.0, 30, Colors.yellow),
    NutritionalStatus ('o1', 'Obese class I', 30.0, 35, Colors.red.shade100),
    NutritionalStatus ('o2', 'Obese class II', 35.0, 40, Colors.red.shade300),
    NutritionalStatus ('o3', 'Obese class III', 40.0, 100, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {

    // listens stream of CalculatorBloc, which
    // - triggers when new CalculatorState is received from stream
    // - widgets are built when previous and current object are not equal
    // - builder return newly built widget if building has happened
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.bmi != current.bmi,
      builder: (context, state) {
        if (state.bmi == null) {
          return Center(
          child: Text(
            S.of(context).not_calculated,
            key: const ValueKey ('not-calculated'),
          ),
        );
        } else {
          var current = statuses.lastWhere((e) => e.minBmi <= state.bmi);
          return Container(
          height: MediaQuery.of(context).size.height * 30/100,
          width:MediaQuery.of(context).size.width * 60/100,
          child: Column(
            children: [
              Text(
                S.of(context).bmi_result(state.bmi),
                key: const ValueKey ('bmi'),
                style: Theme.of(context).textTheme.headline4.apply(
                    color: current.color
                ),
              ),
              Text(
              S.of(context).bmi_desc(current.id),
                key: const ValueKey ('bmi-name'),
                style: Theme.of(context).textTheme.headline6.apply(
                    color: current.color
                ),
              ),
              Expanded(
                child: charts.BarChart (
                    _statusSeries(state.bmi),
                    animate: false,
                    barGroupingType: charts.BarGroupingType.stacked,
                    vertical: false,
                    customSeriesRenderers: [
                      charts.BarTargetLineRendererConfig<String>(
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
  List<charts.Series<NutritionalStatus, String>> _statusSeries(double bmi) {
    final result = [
      NutritionalStatus ('ME', 'My BMI', bmi, bmi, Colors.black),
    ];

    return [
      charts.Series<NutritionalStatus, String>(
        id: 'BMI Scale',
        domainFn: (NutritionalStatus st, _) => 'BMI',
        measureFn: (NutritionalStatus st, _) => st.maxBmi - st.minBmi,
        // NOTE: Colors which charts uses are from charts_flutter package 
        // one needs to have manual conversion fo dart.ui colors
        colorFn: (NutritionalStatus status, _) => charts.Color(
            r: status.color.red, 
            g: status.color.green, 
            b: status.color.blue),
        data: statuses,
      ),
      charts.Series<NutritionalStatus, String>(
        id: 'BMI Result',
        domainFn: (NutritionalStatus status, _) => 'BMI',
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
  NutritionalStatus(this.id, this.name, this.minBmi, this.maxBmi, this.color);

  final String id;
  final String name;
  final double minBmi;
  final double maxBmi;
  final Color color;
}
