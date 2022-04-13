// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_time_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreTimeRead _$StoreTimeReadFromJson(Map<String, dynamic> json) =>
    StoreTimeRead(
      sysStoreTimeId: json['sysStoreTimeId'] as int,
      day: json['day'] as String,
      number: json['number'] as int,
      fromTime: json['fromTime'] as String,
      toTime: json['toTime'] as String,
    );

Map<String, dynamic> _$StoreTimeReadToJson(StoreTimeRead instance) =>
    <String, dynamic>{
      'sysStoreTimeId': instance.sysStoreTimeId,
      'day': instance.day,
      'number': instance.number,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
    };
