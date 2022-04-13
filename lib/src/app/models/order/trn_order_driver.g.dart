// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_order_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnOrderDriver _$TrnOrderDriverFromJson(Map<String, dynamic> json) =>
    TrnOrderDriver(
      plate: json['plate'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      colour: json['colour'] as String,
    );

Map<String, dynamic> _$TrnOrderDriverToJson(TrnOrderDriver instance) =>
    <String, dynamic>{
      'plate': instance.plate,
      'make': instance.make,
      'model': instance.model,
      'colour': instance.colour,
    };
