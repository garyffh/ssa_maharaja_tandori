// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_order_user_allocate_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrnOrderUserAllocateDriver _$TrnOrderUserAllocateDriverFromJson(
        Map<String, dynamic> json) =>
    TrnOrderUserAllocateDriver(
      trnOrderId: json['trnOrderId'] as String,
      deliveryMethodStatus: json['deliveryMethodStatus'] as String,
      plate: json['plate'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      colour: json['colour'] as String,
    );

Map<String, dynamic> _$TrnOrderUserAllocateDriverToJson(
        TrnOrderUserAllocateDriver instance) =>
    <String, dynamic>{
      'trnOrderId': instance.trnOrderId,
      'deliveryMethodStatus': instance.deliveryMethodStatus,
      'plate': instance.plate,
      'make': instance.make,
      'model': instance.model,
      'colour': instance.colour,
    };
