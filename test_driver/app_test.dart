import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/calculate_bmi_steps.dart';

// run at terminal
//  > dart -v test_driver/app_test.dart

// NOTE: when testing locally home screen should be unlocked
// NOTE: if screen is locked driver doesn't manage to use app

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r'test_driver/features/**.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json'),
      StdoutReporter()
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    ..stepDefinitions = [
      createSetValueStep(),
      createCheckValueStep(),
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart'
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
    ..exitAfterTestRun = true; // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);
}