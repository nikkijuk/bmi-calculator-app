// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(bmi) => "bmi is ${bmi}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "bmi_result" : m0,
    "height" : MessageLookupByLibrary.simpleMessage("Length"),
    "height_desc" : MessageLookupByLibrary.simpleMessage("Lenght in centimeters"),
    "level_n_name" : MessageLookupByLibrary.simpleMessage("Normal Weight"),
    "level_o1_name" : MessageLookupByLibrary.simpleMessage("Obese Class I"),
    "level_o2_name" : MessageLookupByLibrary.simpleMessage("Obese Class II"),
    "level_o3_name" : MessageLookupByLibrary.simpleMessage("Obese Class III"),
    "level_po_name" : MessageLookupByLibrary.simpleMessage("Overweight"),
    "level_t1_name" : MessageLookupByLibrary.simpleMessage("Mild Thinness"),
    "level_t2_name" : MessageLookupByLibrary.simpleMessage("Moderate Thinness"),
    "level_t3_name" : MessageLookupByLibrary.simpleMessage("Severe Thinness"),
    "not_calculated" : MessageLookupByLibrary.simpleMessage("not calculated"),
    "title" : MessageLookupByLibrary.simpleMessage("BMI Calculator"),
    "weight" : MessageLookupByLibrary.simpleMessage("Weight"),
    "weight_desc" : MessageLookupByLibrary.simpleMessage("Weight in kilos")
  };
}
