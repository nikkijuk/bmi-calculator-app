import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:bmi_calculator_app/bloc/localization_bloc.dart';
import 'package:bmi_calculator_app/generated/l10n.dart';
import 'package:bmi_calculator_app/widgets/BmiCalculationResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalculatorPage extends StatefulWidget {

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
      return BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Center (
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  LanguageSelection(),
                  HeightInput (),
                  WeightInput (),
                  BmiCalculationResult(),
                ],
              )
            ),
          );
        },
      );
    }
}

class LanguageSelection extends StatefulWidget {

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {

  @override
  Widget build(BuildContext context) {

      return Container(
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration:
            BoxDecoration(
                border: Border.all(
                  style: BorderStyle.none,
                ),
            ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () {
                  setState(() {
                    context.bloc<LocalizationBloc>().add(
                        const Locale('en', 'US')
                    );
                  });
                },
                child:
                  SvgPicture.asset(
                    'icons/flags/svg/gb.svg',
                    package: 'country_icons',
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    context.bloc<LocalizationBloc>().add(
                        const Locale('de', 'DE')
                    );
                  });
                },
                child:
                  SvgPicture.asset(
                    'icons/flags/svg/de.svg',
                    package: 'country_icons',
                    height: 40.0,
                    width: 40.0,),
                ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    context.bloc<LocalizationBloc>().add(
                        const Locale('fi', 'FI')
                    );
                  });
                },
                child:
                  SvgPicture.asset(
                    'icons/flags/svg/fi.svg',
                    package: 'country_icons',
                    height: 40.0,
                    width: 40.0,),
                ),
            ],
          ),
        ),
      );
    }
  }

class HeightInput extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // create callback handler, which
    // - uses BlocProvider to find CalculatorBloc using it's type
    // - adds new CalculatorHeightChangedEvent to sink of CalculatorBloc
    void _onHeightChanged(String value) =>
        context.bloc<CalculatorBloc>().add(
            CalculatorHeightChanged(height: _parseDoubleOrNull(value))
        );

    // listens stream of CalculatorBloc, which
    // - triggers when new CalculatorState is received from stream
    // - wwidgets are built when previous and current object are not equal
    // - builder return newly built widget if building has happened
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.height != current.height,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            key: const ValueKey ('height'),
            initialValue: state.height?.toString() ?? '',
            decoration: InputDecoration(
              icon: const Icon(Icons.vertical_align_center),
              labelText: S.of(context).height, // 'Height',
              hintText: S.of(context).height_desc, // 'Height in centimeters',
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(8),
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
        context.bloc<CalculatorBloc>().add(
            CalculatorWeightChanged(weight: _parseDoubleOrNull(value))
        );

    return BlocBuilder<CalculatorBloc, CalculatorState>(
      buildWhen: (previous, current) => previous.weight != current.weight,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8) ,
          child: TextFormField(
            key: const ValueKey ('weight'),
            initialValue: state.weight?.toString() ?? '',
            decoration: InputDecoration(
              icon: const Icon(Icons.restaurant),
              labelText: S.of(context).weight, // 'Weight',
              hintText: S.of(context).weight_desc, //'Weight in kilograms',
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(8),
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
double _parseDoubleOrNull(String value) =>
    value != null && value != '' ? double.parse(value) : null;

