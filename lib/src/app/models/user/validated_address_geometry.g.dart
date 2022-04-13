// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validated_address_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatedAddressGeometry _$ValidatedAddressGeometryFromJson(
        Map<String, dynamic> json) =>
    ValidatedAddressGeometry(
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$ValidatedAddressGeometryToJson(
        ValidatedAddressGeometry instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
    };
