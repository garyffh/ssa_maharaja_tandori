// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condiment_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CondimentTable _$CondimentTableFromJson(Map<String, dynamic> json) =>
    CondimentTable(
      sysCondimentTableId: json['sysCondimentTableId'] as String,
      number: json['number'] as int,
      name: json['name'] as String,
      multiple: json['multiple'] as bool,
      tQty: (json['tQty'] as num).toDouble(),
      defaultItem: json['defaultItem'] as bool,
      cP1Enabled: json['cP1Enabled'] as bool,
      cP1ZeroPrice: json['cP1ZeroPrice'] as bool,
      cP1ButtonDescription: json['cP1ButtonDescription'] as String,
      cP1PrintDescription: json['cP1PrintDescription'] as String,
      cP2Enabled: json['cP2Enabled'] as bool,
      cP2ZeroPrice: json['cP2ZeroPrice'] as bool,
      cP2ButtonDescription: json['cP2ButtonDescription'] as String,
      cP2PrintDescription: json['cP2PrintDescription'] as String,
      cP3Enabled: json['cP3Enabled'] as bool,
      cP3ZeroPrice: json['cP3ZeroPrice'] as bool,
      cP3ButtonDescription: json['cP3ButtonDescription'] as String,
      cP3PrintDescription: json['cP3PrintDescription'] as String,
      cP4Enabled: json['cP4Enabled'] as bool,
      cP4ZeroPrice: json['cP4ZeroPrice'] as bool,
      cP4ButtonDescription: json['cP4ButtonDescription'] as String,
      cP4PrintDescription: json['cP4PrintDescription'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CondimentTableItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CondimentTableToJson(CondimentTable instance) =>
    <String, dynamic>{
      'sysCondimentTableId': instance.sysCondimentTableId,
      'number': instance.number,
      'name': instance.name,
      'multiple': instance.multiple,
      'tQty': instance.tQty,
      'defaultItem': instance.defaultItem,
      'cP1Enabled': instance.cP1Enabled,
      'cP1ZeroPrice': instance.cP1ZeroPrice,
      'cP1ButtonDescription': instance.cP1ButtonDescription,
      'cP1PrintDescription': instance.cP1PrintDescription,
      'cP2Enabled': instance.cP2Enabled,
      'cP2ZeroPrice': instance.cP2ZeroPrice,
      'cP2ButtonDescription': instance.cP2ButtonDescription,
      'cP2PrintDescription': instance.cP2PrintDescription,
      'cP3Enabled': instance.cP3Enabled,
      'cP3ZeroPrice': instance.cP3ZeroPrice,
      'cP3ButtonDescription': instance.cP3ButtonDescription,
      'cP3PrintDescription': instance.cP3PrintDescription,
      'cP4Enabled': instance.cP4Enabled,
      'cP4ZeroPrice': instance.cP4ZeroPrice,
      'cP4ButtonDescription': instance.cP4ButtonDescription,
      'cP4PrintDescription': instance.cP4PrintDescription,
      'items': instance.items,
    };
