// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitialStore _$InitialStoreFromJson(Map<String, dynamic> json) => InitialStore(
      businessIdentity: json['businessIdentity'] as String,
      businessName: json['businessName'] as String,
      companyNumber: json['companyNumber'] as String?,
      taxRate: (json['taxRate'] as num).toDouble(),
      phone: json['phone'] as String,
      email: json['email'] as String,
      street: json['street'] as String,
      extended: json['extended'] as String,
      locality: json['locality'] as String,
      region: json['region'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timeZone: json['timeZone'] as String,
      deliveryDistance: (json['deliveryDistance'] as num).toDouble(),
      topMenuCategories: json['topMenuCategories'] as int,
      priceLevel: json['priceLevel'] as int,
      pointRedemptionRatio: json['pointRedemptionRatio'] as int,
      cardReadTypeId: json['cardReadTypeId'] as int,
      minOrder: (json['minOrder'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      minimumEftpos: (json['minimumEftpos'] as num).toDouble(),
      tableService: json['tableService'] as bool,
      googleApiKey: json['googleApiKey'] as String?,
      theme: json['theme'] as String,
      newAccounts: json['newAccounts'] as bool,
      promoRate: (json['promoRate'] as num).toDouble(),
      deliveryPromoEnabled: json['deliveryPromoEnabled'] as bool,
      useDeliveryPeriods: json['useDeliveryPeriods'] as bool,
      signInRequired: json['signInRequired'] as bool,
      storeStatus:
          StoreStatus.fromJson(json['storeStatus'] as Map<String, dynamic>),
      paymentProviders: (json['paymentProviders'] as List<dynamic>)
          .map((e) => PaymentProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
      storeDeliveryZones: (json['storeDeliveryZones'] as List<dynamic>)
          .map((e) => StoreDeliveryZone.fromJson(e as Map<String, dynamic>))
          .toList(),
      storeCategories: (json['storeCategories'] as List<dynamic>)
          .map((e) => StoreCategoryRead.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InitialStoreToJson(InitialStore instance) =>
    <String, dynamic>{
      'businessIdentity': instance.businessIdentity,
      'businessName': instance.businessName,
      'companyNumber': instance.companyNumber,
      'taxRate': instance.taxRate,
      'phone': instance.phone,
      'email': instance.email,
      'street': instance.street,
      'extended': instance.extended,
      'locality': instance.locality,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'timeZone': instance.timeZone,
      'deliveryDistance': instance.deliveryDistance,
      'topMenuCategories': instance.topMenuCategories,
      'priceLevel': instance.priceLevel,
      'pointRedemptionRatio': instance.pointRedemptionRatio,
      'cardReadTypeId': instance.cardReadTypeId,
      'minOrder': instance.minOrder,
      'deliveryFee': instance.deliveryFee,
      'minimumEftpos': instance.minimumEftpos,
      'tableService': instance.tableService,
      'googleApiKey': instance.googleApiKey,
      'theme': instance.theme,
      'newAccounts': instance.newAccounts,
      'promoRate': instance.promoRate,
      'deliveryPromoEnabled': instance.deliveryPromoEnabled,
      'useDeliveryPeriods': instance.useDeliveryPeriods,
      'signInRequired': instance.signInRequired,
      'storeStatus': instance.storeStatus,
      'paymentProviders': instance.paymentProviders,
      'storeDeliveryZones': instance.storeDeliveryZones,
      'storeCategories': instance.storeCategories,
    };
