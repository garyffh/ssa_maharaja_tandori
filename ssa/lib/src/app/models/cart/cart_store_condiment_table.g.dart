// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store_condiment_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartStoreCondimentTable _$CartStoreCondimentTableFromJson(
        Map<String, dynamic> json) =>
    CartStoreCondimentTable(
      index: json['index'] as int,
      sysCondimentTableId: json['sysCondimentTableId'] as String,
      name: json['name'] as String,
      selectedItems: (json['selectedItems'] as List<dynamic>)
          .map((e) =>
              CartStoreCondimentTableItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartStoreCondimentTableToJson(
        CartStoreCondimentTable instance) =>
    <String, dynamic>{
      'index': instance.index,
      'sysCondimentTableId': instance.sysCondimentTableId,
      'name': instance.name,
      'selectedItems': instance.selectedItems,
    };
