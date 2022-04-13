
import 'package:flutter/cupertino.dart';

@immutable
class AddressResult {
  const AddressResult({
    required this.street,
    required this.extended,
    required this.locality,
    required this.region,
    required this.postalCode,
    required this.country,
    required this.lat,
    required this.lng,
    required this.distance,
  });

  final String street;
  final String extended;
  final String locality;
  final String region;
  final String postalCode;
  final String country;
  final double? lat;
  final double? lng;
  final double? distance;


}
