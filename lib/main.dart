import 'package:bmi_calculator_app/bloc/calculator_bloc.dart';
import 'package:bmi_calculator_app/pages/calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/simple_bloc_observer.dart';
import 'domain/traditional_bmi_calculator.dart';

void main() {

  // adds logging so that bloc operations are easier to follow
  Bloc.observer = SimpleBlocObserver();

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
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('BMI Calculator')),
        body: BlocProvider(
          create: (_) => CalculatorBloc(TraditionalBmiCalculator()),
          child: CalculatorPage(),
        ),
      ),
    );
  }
}