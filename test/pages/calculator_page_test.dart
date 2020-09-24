// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calculator_app/main.dart';

void main() {
  testWidgets('BMI calculator smoke test', (WidgetTester tester) async {

    // Build our app and trigger a frame.
    await tester.pumpWidget(BmiCalculatorApp());

    // quick fix: wait for the localization delegate's Future to complete.
    // read also: https://github.com/flutter/flutter/issues/22193
    // summary: "Assets are failing to load in tests when they are over 10Kb.
    // This is really confusing and hard to debug behaviour."
    await tester.pumpAndSettle();

    // check 'height' and 'weight' input widgets are there
    expect(find.byKey (ValueKey("height")), findsOneWidget);
    expect(find.byKey (ValueKey("weight")), findsOneWidget);

    // check 'bmi' output widgets is not there
    expect(find.byKey (ValueKey("bmi")), findsNothing);
    expect(find.byKey (ValueKey("bmi-name")), findsNothing);

    // check 'not-calculated' output widget is there
    expect(find.byKey (ValueKey("not-calculated")), findsOneWidget);

    // check that "not calculated" text is visible
    expect(find.text('not calculated'), findsOneWidget);

    // set height
    await tester.enterText(find.byKey (ValueKey("height")), '170');
    await tester.pump(); // trigger frame rendering

    // part set, bmi not calculated
    expect(find.text('not calculated'), findsOneWidget);

    // set weight
    await tester.enterText(find.byKey (ValueKey("weight")), '70');
    await tester.pump(); // trigger frame rendering

    // check "bmi" is shown
    expect(find.byKey(ValueKey("bmi")), findsOneWidget);
    expect(find.byKey(ValueKey("bmi-name")), findsOneWidget);

    // print out result field - very primitive debug option, works with me
    debugPrint (find.byKey(ValueKey("bmi")).evaluate().join(","));
    debugPrint (find.byKey(ValueKey("bmi-name")).evaluate().join(","));

    // check not calculated is not shown
    expect(find.byKey(ValueKey("not-calculated")), findsNothing);

    // bmi should have now changed after setting value to fields and rendering widgets
    expect(find.text('not calculated'), findsNothing);

    expect(find.text('bmi is 24.22'), findsOneWidget);
    expect(find.text('Normal Weight'), findsOneWidget);

  });
}
