import 'package:bmi_calculator_app/bloc/localization_bloc.dart';
import 'package:bmi_calculator_app/bloc/simple_bloc_observer.dart';
import 'package:bmi_calculator_app/generated/l10n.dart';
import 'package:bmi_calculator_app/pages/calculator_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// remember: generation is done using IDE in this project,
// so you might easily keep on old version.
// version number is added to dependencies and generation can be done
// from command line.
// > flutter pub run intl_utils:generate

void main() {

  // adds properties to toString method of classes using Equatable
  // note: this helps by adding details to log output of SimpleBlocObserver
  EquatableConfig.stringify = true;

  // disable landscape and run app
  WidgetsFlutterBinding.ensureInitialized(); // ios simulator needed this line
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (_) =>
        BlocOverrides.runZoned(
          () => runApp(const BmiCalculatorApp()),

          // adds logging so that bloc operations are easier to follow
          // use onEvent to implement logging
          blocObserver: SimpleBlocObserver(),
        ),
  );

}

// This widget is the root of app
class BmiCalculatorApp extends StatelessWidget {
  const BmiCalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalizationBloc>(
      create: (_) => LocalizationBloc(),
      child: BlocBuilder<LocalizationBloc, Locale>(
        builder: (context, locale) => MaterialApp(
          locale: locale,
          localizationsDelegates: const [
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
          home: BmiCalculatorHome(),
        ),
      ),
    );
  }
}

// delegates need to exist higher in widget tree
// https://github.com/flutter/flutter/issues/26365
// ignore: use_key_in_widget_constructors
class BmiCalculatorHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            // Here localized text is always accessible
            // so: no short circuiting with "?" for bdd (flutter_driver) tests
            S.of(context).title,
            key: const ValueKey ('app-title'),
          ),
      ),
      body: const CalculatorPage(),
      );
  }
}