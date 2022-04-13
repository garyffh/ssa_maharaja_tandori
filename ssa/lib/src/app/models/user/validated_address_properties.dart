import 'package:json_annotation/json_annotation.dart';

part 'validated_address_properties.g.dart';

@JsonSerializable()
class ValidatedAddressProperties {
  ValidatedAddressProperties({
    required this.streetName,
    required this.streetTypeDescription,
    this.streetSuffix,
    required this.localityName,
    required this.postcode,
    required this.stateTerritory,
    this.streetNumber1,
    this.streetNumber2,
    this.complexUnitIdentifier,
    this.complexLevelNumber,
    this.complexUnitTypeDescription,
    this.complexLevelTypeDescription,
  });

  factory ValidatedAddressProperties.fromJson(Map<String, dynamic> json) =>
      _$ValidatedAddressPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatedAddressPropertiesToJson(this);

  @JsonKey(name: 'street_name')
  final String streetName;
  @JsonKey(name: 'street_type_description')
  final String streetTypeDescription;
  @JsonKey(name: 'street_suffix')
  final String? streetSuffix;

  @JsonKey(name: 'locality_name')
  final String localityName;
  final String postcode;
  @JsonKey(name: 'state_territory')
  final String stateTerritory;

  @JsonKey(name: 'street_number_1')
  final String? streetNumber1;
  @JsonKey(name: 'street_number_2')
  final String? streetNumber2;


  @JsonKey(name: 'complex_unit_identifier')
  final String? complexUnitIdentifier;
  @JsonKey(name: 'complex_level_number')
  final String? complexLevelNumber;
  @JsonKey(name: 'complex_unit_type_description')
  final String? complexUnitTypeDescription;
  @JsonKey(name: 'complex_level_type_description')
  final String? complexLevelTypeDescription;
}
