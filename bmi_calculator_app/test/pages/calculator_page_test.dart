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

    // pre

    // check 'height' and 'weight' input widgets are there
    expect(find.byKey (ValueKey("height")), findsOneWidget);
    expect(find.byKey (ValueKey("weight")), findsOneWidget);

    // check 'not-calculated' output widget is there
    expect(find.byKey (ValueKey("not-calculated")), findsOneWidget);

    // check 'bmi' output widgets is not there
    expect(find.byKey (ValueKey("bmi")), findsNothing);

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

    // check bmi is shown
    expect(find.byKey(ValueKey("bmi")), findsOneWidget);

    // bmi should have now changed after setting value to fields and rendering widgets
    expect(find.text('not calculated'), findsNothing); // shouldn't be there anymore
    expect(find.text('Bmi is 24.22'), findsOneWidget); // calculated value should be there
  });
}
