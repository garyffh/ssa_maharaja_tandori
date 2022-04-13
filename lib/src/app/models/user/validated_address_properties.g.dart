// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validated_address_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatedAddressProperties _$ValidatedAddressPropertiesFromJson(
        Map<String, dynamic> json) =>
    ValidatedAddressProperties(
      streetName: json['street_name'] as String,
      streetTypeDescription: json['street_type_description'] as String,
      streetSuffix: json['street_suffix'] as String?,
      localityName: json['locality_name'] as String,
      postcode: json['postcode'] as String,
      stateTerritory: json['state_territory'] as String,
      streetNumber1: json['street_number_1'] as String?,
      streetNumber2: json['street_number_2'] as String?,
      complexUnitIdentifier: json['complex_unit_identifier'] as String?,
      complexLevelNumber: json['complex_level_number'] as String?,
      complexUnitTypeDescription:
          json['complex_unit_type_description'] as String?,
      complexLevelTypeDescription:
          json['complex_level_type_description'] as String?,
    );

Map<String, dynamic> _$ValidatedAddressPropertiesToJson(
        ValidatedAddressProperties instance) =>
    <String, dynamic>{
      'street_name': instance.streetName,
      'street_type_description': instance.streetTypeDescription,
      'street_suffix': instance.streetSuffix,
      'locality_name': instance.localityName,
      'postcode': instance.postcode,
      'state_territory': instance.stateTerritory,
      'street_number_1': instance.streetNumber1,
      'street_number_2': instance.streetNumber2,
      'complex_unit_identifier': instance.complexUnitIdentifier,
      'complex_level_number': instance.complexLevelNumber,
      'complex_unit_type_description': instance.complexUnitTypeDescription,
      'complex_level_type_description': instance.complexLevelTypeDescription,
    };
