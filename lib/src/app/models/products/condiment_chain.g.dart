// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condiment_chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CondimentChain _$CondimentChainFromJson(Map<String, dynamic> json) =>
    CondimentChain(
      sysCondimentChainId: json['sysCondimentChainId'] as String,
      number: json['number'] as int,
      name: json['name'] as String,
      condimentTables: (json['condimentTables'] as List<dynamic>)
          .map((e) => CondimentTable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CondimentChainToJson(CondimentChain instance) =>
    <String, dynamic>{
      'sysCondimentChainId': instance.sysCondimentChainId,
      'number': instance.number,
      'name': instance.name,
      'condimentTables': instance.condimentTables,
    };
