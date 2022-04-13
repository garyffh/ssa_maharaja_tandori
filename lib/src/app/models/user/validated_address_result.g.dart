// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validated_address_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatedAddressResult _$ValidatedAddressResultFromJson(
        Map<String, dynamic> json) =>
    ValidatedAddressResult(
      address:
          ValidatedAddress.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidatedAddressResultToJson(
        ValidatedAddressResult instance) =>
    <String, dynamic>{
      'address': instance.address,
    };
