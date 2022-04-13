import 'dart:convert';

class Utilities {
  Utilities._();

  static String printPretty(Map json) {
    return  const JsonEncoder.withIndent('  ').convert(json);
  }


}

