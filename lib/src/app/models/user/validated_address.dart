import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/user/validated_address_geometry.dart';
import 'package:single_store_app/src/app/models/user/validated_address_properties.dart';

part 'validated_address.g.dart';

@JsonSerializable()
class ValidatedAddress {
  ValidatedAddress({
    required this.geometry,
    required this.properties,
    this.distance = 0,
  });

  factory ValidatedAddress.fromJson(Map<String, dynamic> json) =>
      _$ValidatedAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatedAddressToJson(this);

  final ValidatedAddressGeometry geometry;
  final ValidatedAddressProperties properties;
  final double distance;

  double get lng {
    if (geometry.coordinates.length == 2) {
      return geometry.coordinates[0];
    } else {
      return 0;
    }
  }

  double get lat {
    if (geometry.coordinates.length == 2) {
      return geometry.coordinates[1];
    } else {
      return 0;
    }
  }

  bool get validated {
    return true;
  }

  String get street {
    String rtn = '';
    if ((properties.streetNumber1 != null &&
            properties.streetNumber2 != null) &&
        (properties.streetNumber1!.isNotEmpty &&
            properties.streetNumber2!.isNotEmpty)) {
      rtn = '${properties.streetNumber1}-${properties.streetNumber2}';
    } else if (properties.streetNumber1 != null &&
        properties.streetNumber1!.isNotEmpty) {
      rtn = properties.streetNumber1!;
    }

    rtn = '$rtn ${properties.streetName} ${properties.streetTypeDescription}';

    if (properties.streetSuffix != null &&
        properties.streetSuffix!.isNotEmpty) {
      rtn = '$rtn ${properties.streetSuffix}';
    }

    return rtn;
  }

  String get extended {
    if ((properties.complexUnitIdentifier != null &&
            properties.complexLevelNumber != null) &&
        (properties.complexUnitIdentifier!.isNotEmpty &&
            properties.complexLevelNumber!.isNotEmpty)) {
      return '${properties.complexUnitTypeDescription} ${properties.complexUnitIdentifier} ${properties.complexLevelTypeDescription} ${properties.complexLevelNumber}';
    } else if (properties.complexUnitIdentifier != null &&
        properties.complexUnitIdentifier!.isNotEmpty) {
      return '${properties.complexUnitTypeDescription} ${properties.complexUnitIdentifier}';
    } else if (properties.complexLevelNumber != null &&
        properties.complexLevelNumber!.isNotEmpty) {
      return '${properties.complexLevelTypeDescription} ${properties.complexLevelNumber}';
    } else {
      return '';
    }
  }

  String get locality {
    return properties.localityName;
  }

  String get region {
    return properties.stateTerritory;
  }

  String get postalCode {
    return properties.postcode;
  }

  String get country {
    return 'Australia';
  }
}
