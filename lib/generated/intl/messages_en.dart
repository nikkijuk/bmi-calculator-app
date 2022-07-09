// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(Object bmiLevel) => "${Intl.select(bmiLevel, {
            't3': 'Severe Thinness',
            't2': 'Moderate Thinness',
            't1': 'Mild Thinness',
            'n': 'Normal Weight',
            'po': 'Overweight',
            'o1': 'Obese Class I',
            'o2': 'Obese Class II',
            'o3': 'Obese Class III',
            'other': 'N/A',
          })}";

  static String m1(bmi) => "bmi is ${bmi}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bmi_desc": m0,
        "bmi_result": m1,
        "height": MessageLookupByLibrary.simpleMessage("Length"),
        "height_desc":
            MessageLookupByLibrary.simpleMessage("Lenght in centimeters"),
        "not_calculated":
            MessageLookupByLibrary.simpleMessage("not calculated"),
        "title": MessageLookupByLibrary.simpleMessage("BMI Calculator"),
        "weight": MessageLookupByLibrary.simpleMessage("Weight"),
        "weight_desc": MessageLookupByLibrary.simpleMessage("Weight in kilos")
      };
}
