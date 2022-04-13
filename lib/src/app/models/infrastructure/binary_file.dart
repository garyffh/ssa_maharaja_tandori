import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';

part 'binary_file.g.dart';

@JsonSerializable()
class BinaryFile {
  BinaryFile({
    required this.fileName,
    required this.contentType,
    required this.data,
  });

  factory BinaryFile.fromJson(Map<String, dynamic> json) =>
      _$BinaryFileFromJson(json);

  Map<String, dynamic> toJson() => _$BinaryFileToJson(this);

  final String fileName;
  final String contentType;

  @Uint8ListConverter()
  final Uint8List data;

}
