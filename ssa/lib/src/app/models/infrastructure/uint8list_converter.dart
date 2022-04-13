
import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

class Uint8ListConverter implements JsonConverter<Uint8List, String> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(String json) {
    return base64Decode(json);
  }

  @override
  String toJson(Uint8List object) {

    return base64Encode(object);
  }
}

class Uint8ListNullConverter implements JsonConverter<Uint8List?, String?> {
  const Uint8ListNullConverter();

  @override
  Uint8List? fromJson(String? json) {
    if (json == null) {
      return null;
    }

    return base64Decode(json);
  }

  @override
  String? toJson(Uint8List? object) {
    if (object == null) {
      return null;
    }

    return base64Encode(object);
  }
}
