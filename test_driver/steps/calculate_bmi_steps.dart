import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

// It would be possible to define steps as classes, see example from here
// https://github.com/JankariTech/flutterBDDexample
// https://github.com/JankariTech/flutterBDDexample/blob/master/myapp/test_driver/steps/tap_button_n_times_step.dart

// It would have been possible to use built in steps instead building own
// https://pub.dev/packages/flutter_gherkin#flutter

// built in: I fill the {string} field with {string}
StepDefinitionGeneric createSetValueStep() {
  return when2<String, String, FlutterWorld>(
    'I set field {string} to value {string}',
        (key, value, context) async {
      final locator = find.byValueKey(key);
      await FlutterDriverUtils.enterText(context.world.driver, locator, value);
    },
  );
}

// built in: I expect the {string} to be {string}
StepDefinitionGeneric createCheckValueStep() {
  return then2<String, String, FlutterWorld>(
    'I expect field {string} to have value {string}',
        (key, expected, context) async {
      final locator = find.byValueKey(key);
      final actual = await FlutterDriverUtils.getText(context.world.driver!, locator);
      context.expectMatch(actual, expected);
    },
  );
}
