// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestAddress _$SuggestAddressFromJson(Map<String, dynamic> json) =>
    SuggestAddress(
      id: json['id'] as String,
      address: json['address'] as String,
      rank: json['rank'] as int,
    );

Map<String, dynamic> _$SuggestAddressToJson(SuggestAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'rank': instance.rank,
    };
