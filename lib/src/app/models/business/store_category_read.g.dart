// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_category_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreCategoryRead _$StoreCategoryReadFromJson(Map<String, dynamic> json) =>
    StoreCategoryRead(
      sysStoreCategoryId: json['sysStoreCategoryId'] as String,
      number: json['number'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$StoreCategoryReadToJson(StoreCategoryRead instance) =>
    <String, dynamic>{
      'sysStoreCategoryId': instance.sysStoreCategoryId,
      'number': instance.number,
      'name': instance.name,
    };
