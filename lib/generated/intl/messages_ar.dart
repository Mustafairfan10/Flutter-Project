// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(item) => "تمت إضافة ${item} إلى السلة";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("أضف"),
    "addedToCart": m0,
    "appTitle": MessageLookupByLibrary.simpleMessage("تطبيق طلب الطعام"),
    "cartEmpty": MessageLookupByLibrary.simpleMessage("سلة التسوق فارغة."),
    "checkout": MessageLookupByLibrary.simpleMessage("الدفع"),
    "checkoutNotImplemented": MessageLookupByLibrary.simpleMessage(
      "الدفع غير متوفر حاليا",
    ),
    "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "menu": MessageLookupByLibrary.simpleMessage("القائمة"),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "pleaseEnterEmail": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال البريد الإلكتروني",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال كلمة المرور",
    ),
    "total": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "yourCart": MessageLookupByLibrary.simpleMessage("سلة التسوق الخاصة بك"),
  };
}
