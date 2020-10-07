import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class SetHeightValue extends Given1WithWorld<String, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'the height is {string}');

  @override
  Future<void> executeStep(String value) async {
    await setField(world, timeout, 'height', value);
  }
}

class SetWeightValue extends Given1WithWorld<String, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'the weight is {string}');

  @override
  Future<void> executeStep(String value) async {
    await setField(world, timeout, 'weight', value);
  }
}

class CheckBmiValue extends Then1WithWorld<String, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'I expect the bmi is {string}');

  @override
  Future<void> executeStep(String expect) async {
    var found = await getField(world, timeout, 'bmi-result');
    if (expect != found) {
      throw Exception(
          'bmi should have been $expect, but was $found');
    }
  }
}

Future<void> setField(FlutterWorld world, Duration timeout, String fieldKey, String value) async {
  final locator = find.byValueKey(fieldKey);
  await FlutterDriverUtils.tap(world.driver, locator);
  return FlutterDriverUtils.enterText(world.driver, locator, value);
}

Future<String> getField(FlutterWorld world, Duration timeout, String fieldKey) async {
  final locator = find.byValueKey(fieldKey);
  return FlutterDriverUtils.getText(world.driver, locator);
}
