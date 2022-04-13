// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validated_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatedAddress _$ValidatedAddressFromJson(Map<String, dynamic> json) =>
    ValidatedAddress(
      geometry: ValidatedAddressGeometry.fromJson(
          json['geometry'] as Map<String, dynamic>),
      properties: ValidatedAddressProperties.fromJson(
          json['properties'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ValidatedAddressToJson(ValidatedAddress instance) =>
    <String, dynamic>{
      'geometry': instance.geometry,
      'properties': instance.properties,
      'distance': instance.distance,
    };
