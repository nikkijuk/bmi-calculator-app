// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
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

  /// `Lenght in centimeters`
  String get height_desc {
    return Intl.message(
      'Lenght in centimeters',
      name: 'height_desc',
      desc: '',
      args: [],
    );
  }

  /// `Normal Weight`
  String get level_n_name {
    return Intl.message(
      'Normal Weight',
      name: 'level_n_name',
      desc: '',
      args: [],
    );
  }

  /// `Obese Class I`
  String get level_o1_name {
    return Intl.message(
      'Obese Class I',
      name: 'level_o1_name',
      desc: '',
      args: [],
    );
  }

  /// `Obese Class II`
  String get level_o2_name {
    return Intl.message(
      'Obese Class II',
      name: 'level_o2_name',
      desc: '',
      args: [],
    );
  }

  /// `Obese Class III`
  String get level_o3_name {
    return Intl.message(
      'Obese Class III',
      name: 'level_o3_name',
      desc: '',
      args: [],
    );
  }

  /// `Overweight`
  String get level_po_name {
    return Intl.message(
      'Overweight',
      name: 'level_po_name',
      desc: '',
      args: [],
    );
  }

  /// `Mild Thinness`
  String get level_t1_name {
    return Intl.message(
      'Mild Thinness',
      name: 'level_t1_name',
      desc: '',
      args: [],
    );
  }

  /// `Moderate Thinness`
  String get level_t2_name {
    return Intl.message(
      'Moderate Thinness',
      name: 'level_t2_name',
      desc: '',
      args: [],
    );
  }

  /// `Severe Thinness`
  String get level_t3_name {
    return Intl.message(
      'Severe Thinness',
      name: 'level_t3_name',
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
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}