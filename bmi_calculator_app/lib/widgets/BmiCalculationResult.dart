import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';

// Complexity of this single component and it's dependencies are reason
// why it has been moved to separate file - there's no need to reuse it
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
                    _nutritionalStatuses(state.bmi),
                    animate: false,
                    barGroupingType: charts.BarGroupingType.stacked,
                    vertical: false,
                    customSeriesRenderers: [
                      new charts.BarTargetLineRendererConfig<String>(
                        // ID used to link series to this renderer.
                          customRendererId: 'customTargetLine',
                          groupingType: charts.BarGroupingType.stacked)
                    ]
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  /// Create series list with multiple series
  /// For data see: https://www.euro.who.int/en/health-topics/disease-prevention/nutrition/a-healthy-lifestyle/body-mass-index-bmi
  List<charts.Series<NutritionalStatus, String>> _nutritionalStatuses(double bmi) {

    // it might be wise to put this data later on to own file - now it's here locally since we only need it here
    final statuses = [
      NutritionalStatus ('U', 'Underweight', 0, 18.5, Colors.red.shade50),
      NutritionalStatus ('N', 'Normal weight', 18.5, 25, Colors.green),
      NutritionalStatus ('PO', 'Pre-obesity', 25.0, 30, Colors.red.shade50),
      NutritionalStatus ('O1', 'Obesity class I', 30.0, 35, Colors.red.shade100),
      NutritionalStatus ('O2', 'Obesity class II', 35.0, 40, Colors.red.shade200),
      NutritionalStatus ('O3', 'Obesity class III', 40.0, 100, Colors.red.shade400),
    ];

    final result = [
      NutritionalStatus ('X', 'Dummy', 0, 18.5, Colors.red.shade50),
    ];

    return [
      new charts.Series<NutritionalStatus, String>(
        id: 'BMI Scale',
        domainFn: (NutritionalStatus status, _) => "BMI",
        measureFn: (NutritionalStatus status, _) => status.maxBmi - status.minBmi,
        colorFn: (NutritionalStatus status, _) => charts.Color(r: status.color.red, g: status.color.green, b: status.color.blue),
        data: statuses,
      ),
      new charts.Series<NutritionalStatus, String>(
        id: 'BMI Result',
        domainFn: (NutritionalStatus status, _) => "BMI",
        measureFn: (NutritionalStatus status, _) => bmi,
        strokeWidthPxFn: (NutritionalStatus status, _) => 6,
        data: result,
      )
      // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customTargetLine'),
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
