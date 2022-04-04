import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:bmi_calculator_app/bloc/localization_bloc.dart';
import 'package:bmi_calculator_app/domain/traditional_bmi_calculator.dart';
import 'package:bmi_calculator_app/generated/l10n.dart';
import 'package:bmi_calculator_app/widgets/BmiCalculationResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// CalculatorPage is skeleton and defines structure of components
class CalculatorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    assert (S.of(context) != null, 'active localization should be present');

    return BlocProvider<CalculatorBloc>(
      create: (_) => CalculatorBloc(TraditionalBmiCalculator()),
      child:
        BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Center (
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                // all components at page are defined separately as widgets
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
        )
    );
  }
}

class LanguageSelection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // TODO: fix
    //assert (context.bloc<LocalizationBloc>() != null, 'bloc for localization should be present');

    // create callback handler, which
    // - uses BlocProvider to find LocalizationBloc using it's type
    // - adds Locale to sink of LocalizationBloc
    void _onLocaleChanged(Locale locale) =>
        context.read<LocalizationBloc>().add(locale);

    // Flags for language selection are presented as row of buttons
    // It's vitally important to select right type of button here:
    // I was spending quite some time to tune wrong component while
    // I didn't know all buttons that were available
    return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              key: const ValueKey ('flag-gb'),
              onPressed: () {
                _onLocaleChanged(const Locale('en', 'US'));
                },
              child:
                SvgPicture.asset(
                  'assets/flags/svg/gb.svg',
                  height: 40.0,
                  width: 40.0,
                ),
              ),
            TextButton(
              key: const ValueKey ('flag-de'),
              onPressed: () {
              _onLocaleChanged(const Locale('de', 'de'));
              },
              child:
                SvgPicture.asset(
                  'assets/flags/svg/de.svg',
                  height: 40.0,
                  width: 40.0,
                ),
              ),
            TextButton(
              key: const ValueKey ('flag-fi'),
              onPressed: () {
                _onLocaleChanged(const Locale('fi', 'FI'));
              },
              child:
                SvgPicture.asset(
                  'assets/flags/svg/fi.svg',
                  height: 40.0,
                  width: 40.0,
                ),
              ),
          ],
      );
    }
}

class HeightInput extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    assert (S.of(context) != null, 'active localization should be present');

    // create callback handler, which
    // - uses BlocProvider to find CalculatorBloc using it's type
    // - adds new CalculatorHeightChangedEvent to sink of CalculatorBloc
    void _onHeightChanged(String value) =>
        context.read<CalculatorBloc>().add(
            CalculatorHeightChanged(height: _parseDoubleOrNull(value))
        );

    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        key: const ValueKey ('height'),
        decoration: InputDecoration(
          icon: const Icon(Icons.vertical_align_center),
          labelText: S.of(context).height,
          hintText: S.of(context).height_desc,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        keyboardType: TextInputType.number,
        onChanged: _onHeightChanged,
      ),
    );
  }
}

class WeightInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    assert (S.of(context) != null, 'active localization should be present');

    void _onWeightChanged(String value) =>
        context.read<CalculatorBloc>().add(
            CalculatorWeightChanged(weight: _parseDoubleOrNull(value))
        );

    return Container(
      padding: const EdgeInsets.all(8) ,
      child: TextFormField(
        key: const ValueKey ('weight'),
        decoration: InputDecoration(
          icon: const Icon(Icons.restaurant),
          labelText: S.of(context).weight,
          hintText: S.of(context).weight_desc,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(8),
        ),
        keyboardType: TextInputType.number,
        onChanged: _onWeightChanged,
      ),
    );
  }
}

// this was tricky: field can contain null, empty or numeric value
double _parseDoubleOrNull(String value) =>
    value != null && value != '' ? double.parse(value) : 0;
