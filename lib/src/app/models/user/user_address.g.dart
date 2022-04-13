// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddress _$UserAddressFromJson(Map<String, dynamic> json) => UserAddress(
      updateId:
          const Uint8ListNullConverter().fromJson(json['updateId'] as String?),
      isBilling: json['isBilling'] as bool,
      isPostal: json['isPostal'] as bool,
      isDelivery: json['isDelivery'] as bool,
      ffhLocalityId: json['ffhLocalityId'] as int?,
      company: json['company'] as String?,
      companyNumber: json['companyNumber'] as String?,
      addressNote: json['addressNote'] as String?,
      street: json['street'] as String,
      extended: json['extended'] as String,
      locality: json['locality'] as String,
      region: json['region'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      timeZoneId: json['timeZoneId'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserAddressToJson(UserAddress instance) =>
    <String, dynamic>{
      'updateId': const Uint8ListNullConverter().toJson(instance.updateId),
      'isBilling': instance.isBilling,
      'isPostal': instance.isPostal,
      'isDelivery': instance.isDelivery,
      'ffhLocalityId': instance.ffhLocalityId,
      'company': instance.company,
      'companyNumber': instance.companyNumber,
      'addressNote': instance.addressNote,
      'street': instance.street,
      'extended': instance.extended,
      'locality': instance.locality,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'timeZoneId': instance.timeZoneId,
      'lat': instance.lat,
      'lng': instance.lng,
      'distance': instance.distance,
    };
