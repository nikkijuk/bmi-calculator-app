import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:bmi_calculator_app/pages/calculator_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/simple_bloc_observer.dart';
import 'domain/traditional_bmi_calculator.dart';
import 'generated/l10n.dart';

void main() {

  // adds logging so that bloc operations are easier to follow
  Bloc.observer = SimpleBlocObserver();

  // adds properties to toString method of classes using Equatable
  // note: this helps by adding details to log output of SimpleBlocObserver
  EquatableConfig.stringify = true;

  // disable landscape and run app
  WidgetsFlutterBinding.ensureInitialized(); // ios simulator needed this line
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  ).then(
    (_) => runApp(BmiCalculatorApp())
  );

}

// This widget is the root of app
class BmiCalculatorApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BmiCalculatorHome(),
    );
  }
}

// delegates need to exist higher in widget tree
// https://github.com/flutter/flutter/issues/26365
class BmiCalculatorHome extends StatelessWidget {
  const BmiCalculatorHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            S.of(context).title
          ),
      ),
      body: BlocProvider(
        create: (_) => CalculatorBloc(TraditionalBmiCalculator()),
        child: CalculatorPage(),
      ),
    );
  }
}