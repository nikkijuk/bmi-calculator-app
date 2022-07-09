// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m0(Object bmiLevel) => "${Intl.select(bmiLevel, {
            't3': 'Starkes Untergewicht',
            't2': 'Moderate Untergewicht',
            't1': 'Leichte Untergewicht',
            'n': 'Normalgewicht',
            'po': 'Übergewicht',
            'o1': 'Adipositas Grad I',
            'o2': 'Adipositas Grad II',
            'o3': 'Adipositas Grad IIII',
            'other': 'N/A',
          })}";

  static String m1(bmi) => "bmi ist ${bmi}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bmi_desc": m0,
        "bmi_result": m1,
        "height": MessageLookupByLibrary.simpleMessage("Länge"),
        "height_desc":
            MessageLookupByLibrary.simpleMessage("Länge in centimeter"),
        "not_calculated":
            MessageLookupByLibrary.simpleMessage("Nicht gerechnet"),
        "title": MessageLookupByLibrary.simpleMessage("BMI Rechner"),
        "weight": MessageLookupByLibrary.simpleMessage("Gewicht"),
        "weight_desc": MessageLookupByLibrary.simpleMessage("Gewicht in kilos")
      };
}
