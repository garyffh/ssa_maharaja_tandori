import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/initial/initial_store.dart';
import 'package:single_store_app/src/app/models/business/payment_provider.dart';
import 'package:single_store_app/src/app/models/business/store_category_read.dart';
import 'package:single_store_app/src/app/models/business/store_delivery_zone.dart';
import 'package:single_store_app/src/app/models/business/store_status.dart';

@immutable
@JsonSerializable()
class StoreSettings {
  const StoreSettings({
    required this.isMultiStore,
    required this.businessIdentity,
    required this.businessName,
    required this.companyNumber,
    required this.taxRate,
    required this.phone,
    required this.email,
    required this.street,
    required this.extended,
    required this.locality,
    required this.region,
    required this.postalCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.timeZone,
    required this.deliveryDistance,
    required this.topMenuCategories,
    required this.priceLevel,
    required this.pointRedemptionRatio,
    required this.cardReadTypeId,
    required this.minOrder,
    required this.deliveryFee,
    required this.minimumEftpos,
    required this.tableService,
    required this.googleApiKey,
    required this.theme,
    required this.newAccounts,
    required this.promoRate,
    required this.deliveryPromoEnabled,
    required this.useDeliveryPeriods,
    required this.signInRequired,
    required this.storeStatus,
    required this.paymentProviders,
    required this.storeDeliveryZones,
    required this.storeCategories,
  });

  StoreSettings.fromInitialStore({
    required this.isMultiStore,
    required InitialStore instance,
  })  : businessIdentity = instance.businessIdentity,
        businessName = instance.businessName,
        companyNumber = instance.companyNumber,
        taxRate = instance.taxRate,
        phone = instance.phone,
        email = instance.email,
        street = instance.street,
        extended = instance.extended,
        locality = instance.locality,
        region = instance.region,
        postalCode = instance.postalCode,
        country = instance.country,
        latitude = instance.latitude,
        longitude = instance.longitude,
        timeZone = instance.timeZone,
        deliveryDistance = instance.deliveryDistance,
        topMenuCategories = instance.topMenuCategories,
        priceLevel = instance.priceLevel,
        pointRedemptionRatio = instance.pointRedemptionRatio,
        cardReadTypeId = instance.cardReadTypeId,
        minOrder = instance.minOrder,
        deliveryFee = instance.deliveryFee,
        minimumEftpos = instance.minimumEftpos,
        tableService = instance.tableService,
        googleApiKey = instance.googleApiKey,
        theme = instance.theme,
        newAccounts = instance.newAccounts,
        promoRate = instance.promoRate,
        deliveryPromoEnabled = instance.deliveryPromoEnabled,
        useDeliveryPeriods = instance.useDeliveryPeriods,
        signInRequired = instance.signInRequired,
        storeStatus = instance.storeStatus,
        paymentProviders = instance.paymentProviders,
        storeDeliveryZones = instance.storeDeliveryZones,
        storeCategories = instance.storeCategories;

  StoreSettings.clone(StoreSettings instance)
      : isMultiStore = instance.isMultiStore,
        businessIdentity = instance.businessIdentity,
        businessName = instance.businessName,
        companyNumber = instance.companyNumber,
        taxRate = instance.taxRate,
        phone = instance.phone,
        email = instance.email,
        street = instance.street,
        extended = instance.extended,
        locality = instance.locality,
        region = instance.region,
        postalCode = instance.postalCode,
        country = instance.country,
        latitude = instance.latitude,
        longitude = instance.longitude,
        timeZone = instance.timeZone,
        deliveryDistance = instance.deliveryDistance,
        topMenuCategories = instance.topMenuCategories,
        priceLevel = instance.priceLevel,
        pointRedemptionRatio = instance.pointRedemptionRatio,
        cardReadTypeId = instance.cardReadTypeId,
        minOrder = instance.minOrder,
        deliveryFee = instance.deliveryFee,
        minimumEftpos = instance.minimumEftpos,
        tableService = instance.tableService,
        googleApiKey = instance.googleApiKey,
        theme = instance.theme,
        newAccounts = instance.newAccounts,
        promoRate = instance.promoRate,
        deliveryPromoEnabled = instance.deliveryPromoEnabled,
        useDeliveryPeriods = instance.useDeliveryPeriods,
        signInRequired = instance.signInRequired,
        storeStatus = instance.storeStatus,
        paymentProviders = instance.paymentProviders,
        storeDeliveryZones = instance.storeDeliveryZones,
        storeCategories = instance.storeCategories;

  final bool isMultiStore;
  final String businessIdentity;
  final String businessName;
  final String? companyNumber;
  final double taxRate;
  final String phone;
  final String email;
  final String street;
  final String extended;
  final String locality;
  final String region;
  final String postalCode;
  final String country;
  final double latitude;
  final double longitude;
  final String timeZone;
  final double deliveryDistance;
  final int topMenuCategories;
  final int priceLevel;
  final int pointRedemptionRatio;
  final int cardReadTypeId;
  final double minOrder;
  final double deliveryFee;
  final double minimumEftpos;
  final bool tableService;
  final String? googleApiKey;
  final String theme;
  final bool newAccounts;
  final double promoRate;
  final bool deliveryPromoEnabled;
  final bool useDeliveryPeriods;
  final bool signInRequired;

  final StoreStatus storeStatus;
  final List<PaymentProvider> paymentProviders;
  final List<StoreDeliveryZone> storeDeliveryZones;
  final List<StoreCategoryRead> storeCategories;

  String get imagesPath => isMultiStore ? 'assets/ffh/$businessIdentity/images' : 'assets/ffh/images';

  bool get usesDeliveryZones => storeDeliveryZones.isNotEmpty;

}
