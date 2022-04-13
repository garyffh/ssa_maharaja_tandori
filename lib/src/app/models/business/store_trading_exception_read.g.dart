// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_trading_exception_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreTradingExceptionRead _$StoreTradingExceptionReadFromJson(
        Map<String, dynamic> json) =>
    StoreTradingExceptionRead(
      sysStoreTradingExceptionId: json['sysStoreTradingExceptionId'] as String,
      name: json['name'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      store: json['store'] as bool,
      delivery: json['delivery'] as bool,
      closed: json['closed'] as bool,
    );

Map<String, dynamic> _$StoreTradingExceptionReadToJson(
        StoreTradingExceptionRead instance) =>
    <String, dynamic>{
      'sysStoreTradingExceptionId': instance.sysStoreTradingExceptionId,
      'name': instance.name,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'store': instance.store,
      'delivery': instance.delivery,
      'closed': instance.closed,
    };
