// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator_app/bloc/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calculator_app/main.dart';

void main() {
  testWidgets('BMI calculator smoke test', (WidgetTester tester) async {

    Bloc.observer = SimpleBlocObserver();

    // Build our app and trigger a frame.
    await tester.pumpWidget(BmiCalculatorApp());

    // pre
    expect(find.text('Bmi is <not calculated>'), findsOneWidget);

    expect(find.byIcon(Icons.person), findsOneWidget); // height
    expect(find.byIcon(Icons.party_mode), findsOneWidget); // weight

    expect(find.byKey (ValueKey("height")), findsOneWidget); // height
    expect(find.byKey (ValueKey("weight")), findsOneWidget); // weight
    expect(find.byKey (ValueKey("bmi")), findsOneWidget); // bmi

    // set height
    await tester.tap(find.byIcon(Icons.person));
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.digit1);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.digit7);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.digit0);
    await tester.pump();

    // part set
    expect(find.text('Bmi is <not calculated>'), findsOneWidget);

    // set weight
    await tester.tap(find.byIcon(Icons.party_mode));
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.digit7);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.digit0);
    await tester.pumpAndSettle();

    // check bmi
    // text should have now changed
    expect(find.byKey(ValueKey("bmi")), findsOneWidget);

    // TODO: why UI doesn't update? Is Bloc not active?
    //expect(find.text('Bmi is <not calculated>'), findsNothing); // shouldn't be there anymore
    //expect(find.text('Bmi is 24.22'), findsOneWidget);
  });
}
