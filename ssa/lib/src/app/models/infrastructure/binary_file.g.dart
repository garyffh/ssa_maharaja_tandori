// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binary_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BinaryFile _$BinaryFileFromJson(Map<String, dynamic> json) => BinaryFile(
      fileName: json['fileName'] as String,
      contentType: json['contentType'] as String,
      data: const Uint8ListConverter().fromJson(json['data'] as String),
    );

Map<String, dynamic> _$BinaryFileToJson(BinaryFile instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'contentType': instance.contentType,
      'data': const Uint8ListConverter().toJson(instance.data),
    };
