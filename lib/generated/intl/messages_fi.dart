// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fi locale. All the
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
  String get localeName => 'fi';

  static String m0(Object bmiLevel) => "${Intl.select(bmiLevel, {
            't3': 'Sairaalloinen alipaino',
            't2': 'Vaikea alipaino',
            't1': 'Alipaino',
            'n': 'Normaalipaino',
            'po': 'Ylipaino',
            'o1': 'Merkittävä ylipaino',
            'o2': 'Vaikea ylipaino',
            'o3': 'Sairaalloinen ylipaino',
            'other': 'N/A',
          })}";

  static String m1(bmi) => "bmi on ${bmi}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bmi_desc": m0,
        "bmi_result": m1,
        "height": MessageLookupByLibrary.simpleMessage("Pituus"),
        "height_desc":
            MessageLookupByLibrary.simpleMessage("Pituus centtimetreinä"),
        "not_calculated": MessageLookupByLibrary.simpleMessage("ei laskettu"),
        "title": MessageLookupByLibrary.simpleMessage("BMI Laskin"),
        "weight": MessageLookupByLibrary.simpleMessage("Paino"),
        "weight_desc": MessageLookupByLibrary.simpleMessage("Paino kiloina")
      };
}
