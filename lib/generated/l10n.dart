// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `{bmiLevel, select, t3 {Severe Thinness} t2 {Moderate Thinness} t1 {Mild Thinness} n {Normal Weight} po {Overweight} o1 {Obese Class I} o2 {Obese Class II} o3 {Obese Class III} other{N/A}}`
  String bmi_desc(Object bmiLevel) {
    return Intl.select(
      bmiLevel,
      {
        't3': 'Severe Thinness',
        't2': 'Moderate Thinness',
        't1': 'Mild Thinness',
        'n': 'Normal Weight',
        'po': 'Overweight',
        'o1': 'Obese Class I',
        'o2': 'Obese Class II',
        'o3': 'Obese Class III',
        'other': 'N/A',
      },
      name: 'bmi_desc',
      desc: '',
      args: [bmiLevel],
    );
  }

  /// `bmi is {bmi}`
  String bmi_result(Object bmi) {
    return Intl.message(
      'bmi is $bmi',
      name: 'bmi_result',
      desc: '',
      args: [bmi],
    );
  }

  /// `Length`
  String get height {
    return Intl.message(
      'Length',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Length in centimeters`
  String get height_desc {
    return Intl.message(
      'Length in centimeters',
      name: 'height_desc',
      desc: '',
      args: [],
    );
  }

  /// `not calculated`
  String get not_calculated {
    return Intl.message(
      'not calculated',
      name: 'not_calculated',
      desc: '',
      args: [],
    );
  }

  /// `BMI Calculator`
  String get title {
    return Intl.message(
      'BMI Calculator',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Weight in kilos`
  String get weight_desc {
    return Intl.message(
      'Weight in kilos',
      name: 'weight_desc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'fi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
