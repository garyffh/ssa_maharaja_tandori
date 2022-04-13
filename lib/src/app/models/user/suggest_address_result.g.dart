// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest_address_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestAddressResult _$SuggestAddressResultFromJson(
        Map<String, dynamic> json) =>
    SuggestAddressResult(
      suggest: (json['suggest'] as List<dynamic>?)
          ?.map((e) => SuggestAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuggestAddressResultToJson(
        SuggestAddressResult instance) =>
    <String, dynamic>{
      'suggest': instance.suggest,
    };
