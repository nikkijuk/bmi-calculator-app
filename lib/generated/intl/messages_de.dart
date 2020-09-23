// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static m0(bmi) => "bmi ist ${bmi}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "bmi_result" : m0,
    "height" : MessageLookupByLibrary.simpleMessage("Länge"),
    "height_desc" : MessageLookupByLibrary.simpleMessage("Länge in centimeter"),
    "level_n_name" : MessageLookupByLibrary.simpleMessage("Normalgewicht"),
    "level_o1_name" : MessageLookupByLibrary.simpleMessage("Adipositas Grad I "),
    "level_o2_name" : MessageLookupByLibrary.simpleMessage("Adipositas Grad II "),
    "level_o3_name" : MessageLookupByLibrary.simpleMessage("Adipositas Grad III"),
    "level_po_name" : MessageLookupByLibrary.simpleMessage("Übergewicht"),
    "level_t1_name" : MessageLookupByLibrary.simpleMessage("Leichte Untergewicht"),
    "level_t2_name" : MessageLookupByLibrary.simpleMessage("Moderate Untergewicht"),
    "level_t3_name" : MessageLookupByLibrary.simpleMessage("Starkes Untergewicht"),
    "not_calculated" : MessageLookupByLibrary.simpleMessage("Nicht gerechnet"),
    "title" : MessageLookupByLibrary.simpleMessage("BMI Rechner"),
    "weight" : MessageLookupByLibrary.simpleMessage("Gewicht"),
    "weight_desc" : MessageLookupByLibrary.simpleMessage("Gewicht in kilos")
  };
}
