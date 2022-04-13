import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';

import 'address_result.dart';

part 'user_address.g.dart';

@JsonSerializable()
class UserAddress {
  UserAddress({
    required this.updateId,
    required this.isBilling,
    required this.isPostal,
    required this.isDelivery,
    required this.ffhLocalityId,
    required this.company,
    required this.companyNumber,
    required this.addressNote,
    required this.street,
    required this.extended,
    required this.locality,
    required this.region,
    required this.postalCode,
    required this.country,
    required this.timeZoneId,
    required this.lat,
    required this.lng,
    required this.distance,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) =>
      _$UserAddressFromJson(json);

  UserAddress.fromAddressResult({
    this.updateId,
    required this.company,
    required this.companyNumber,
    required this.addressNote,
    required AddressResult addressResult,
  })  : timeZoneId = null,
        ffhLocalityId = null,
        isBilling = true,
        isPostal = true,
        isDelivery = true,
        street = addressResult.street,
        extended = addressResult.extended,
        locality = addressResult.locality,
        region = addressResult.region,
        postalCode = addressResult.postalCode,
        country = addressResult.country,
        lat = addressResult.lat,
        lng = addressResult.lng,
        distance = addressResult.distance;

  UserAddress.fromSubmittedAddress(
    this.updateId,
    UserAddress userAddress,
  )   : timeZoneId = null,
        ffhLocalityId = null,
        isBilling = true,
        isPostal = true,
        isDelivery = true,
        company = userAddress.company,
        companyNumber = userAddress.companyNumber,
        addressNote = userAddress.addressNote,
        street = userAddress.street,
        extended = userAddress.extended,
        locality = userAddress.locality,
        region = userAddress.region,
        postalCode = userAddress.postalCode,
        country = userAddress.country,
        lat = userAddress.lat,
        lng = userAddress.lng,
        distance = userAddress.distance;

  Map<String, dynamic> toJson() => _$UserAddressToJson(this);

  @Uint8ListNullConverter()
  final Uint8List? updateId;
  final bool isBilling;
  final bool isPostal;
  final bool isDelivery;
  final int? ffhLocalityId;
  final String? company;
  final String? companyNumber;
  final String? addressNote;
  final String street;
  final String extended;
  final String locality;
  final String region;
  final String postalCode;
  final String country;
  final String? timeZoneId;
  final double? lat;
  final double? lng;
  final double? distance;
}
