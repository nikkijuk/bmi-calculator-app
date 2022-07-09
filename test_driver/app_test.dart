import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/calculate_bmi_steps.dart';

// Component:
// https://pub.dev/packages/flutter_gherkin

// Guides:
// https://dev.to/jankaritech/bdd-behavior-driven-development-with-flutter-31ao
// https://stacksecrets.com/flutter/bdd-with-gherkin-in-flutter
// https://medium.com/@maheshmnj/testing-your-flutter-app-f08ebc54beb9

// run all tests at terminal
//  > dart -v test_driver/app_test.dart
// or
// > flutter drive --target=test_driver/app.dart

// NOTE: when testing locally home screen should be unlocked
// NOTE: if screen is locked driver doesn't manage to use app

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob('test_driver/features/**.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(),
      StdoutReporter()
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..stepDefinitions = [
      createSetValueStep(),
      createCheckValueStep(),
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';
    //..logFlutterProcessOutput = true
    //..verboseFlutterProcessLogs = true
    // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
    // TODO: exitAfterTestRun commented out on 1.x -> 2.x migration
    //..exitAfterTestRun = true; // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);

}
