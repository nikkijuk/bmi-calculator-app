import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:bmi_calculator_app/bloc/localization_bloc.dart';
import 'package:bmi_calculator_app/generated/l10n.dart';
import 'package:bmi_calculator_app/widgets/BmiCalculationResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// CalcultarPage is skeleton and defines structure of compnentes
class CalculatorPage extends StatelessWidget {

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
      );
    }
}

// As we are using setState this needs to be stateful widget
class LanguageSelection extends StatefulWidget {

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  @override
  Widget build(BuildContext context) {

      // Flags for language selection are presented as row of flat buttons
      // It's vitally important to select right type of button here:
      // I was spending quite some time to tune wrong component while
      // I didn't know all buttons that were available
      return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () {
                  // refresh view after lambda within setState is executed
                  setState(() {
                    // inform localization bloc that locale has changed
                    context.bloc<LocalizationBloc>().add(
                        const Locale('en', 'US')
                    );
                  });
                },
                child:

                  SvgPicture.asset(
                    'assets/flags/svg/gb.svg',
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
                    'assets/flags/svg/de.svg',
                    height: 40.0,
                    width: 40.0,
                  ),
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

    // create callback handler, which
    // - uses BlocProvider to find CalculatorBloc using it's type
    // - adds new CalculatorHeightChangedEvent to sink of CalculatorBloc
    void _onHeightChanged(String value) =>
        context.bloc<CalculatorBloc>().add(
            CalculatorHeightChanged(height: _parseDoubleOrNull(value))
        );

    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        key: const ValueKey ('height'),
        decoration: InputDecoration(
          icon: const Icon(Icons.vertical_align_center),
          labelText: S.of(context)?.height,
          hintText: S.of(context)?.height_desc,
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

    void _onWeightChanged(String value) =>
        context.bloc<CalculatorBloc>().add(
            CalculatorWeightChanged(weight: _parseDoubleOrNull(value))
        );

    return Container(
      padding: const EdgeInsets.all(8) ,
      child: TextFormField(
        key: const ValueKey ('weight'),
        decoration: InputDecoration(
          icon: const Icon(Icons.restaurant),
          labelText: S.of(context)?.weight,
          hintText: S.of(context)?.weight_desc,
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
    value != null && value != '' ? double.parse(value) : null;

