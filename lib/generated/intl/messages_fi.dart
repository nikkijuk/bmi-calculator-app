// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fi locale. All the
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
  String get localeName => 'fi';

  static m0(bmi) => "bmi on ${bmi}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "bmi_result" : m0,
    "height" : MessageLookupByLibrary.simpleMessage("Pituus"),
    "height_desc" : MessageLookupByLibrary.simpleMessage("Pituus centtimetreinä"),
    "level_n_name" : MessageLookupByLibrary.simpleMessage("Normaalipaino"),
    "level_o1_name" : MessageLookupByLibrary.simpleMessage("Merkittävä ylipaino"),
    "level_o2_name" : MessageLookupByLibrary.simpleMessage("Vaikea ylipaino"),
    "level_o3_name" : MessageLookupByLibrary.simpleMessage("Sairaalloinen ylipaino"),
    "level_po_name" : MessageLookupByLibrary.simpleMessage("Ylipaino"),
    "level_t1_name" : MessageLookupByLibrary.simpleMessage("Lievä alipaino"),
    "level_t2_name" : MessageLookupByLibrary.simpleMessage("Merkittävä alipaino"),
    "level_t3_name" : MessageLookupByLibrary.simpleMessage("Sairaalloinen alipaino"),
    "not_calculated" : MessageLookupByLibrary.simpleMessage("ei laskettu"),
    "title" : MessageLookupByLibrary.simpleMessage("BMI Laskin"),
    "weight" : MessageLookupByLibrary.simpleMessage("Paino"),
    "weight_desc" : MessageLookupByLibrary.simpleMessage("Paino kiloina")
  };
}
