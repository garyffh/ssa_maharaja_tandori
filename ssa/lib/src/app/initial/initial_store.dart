import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/business/payment_provider.dart';
import 'package:single_store_app/src/app/models/business/store_category_read.dart';
import 'package:single_store_app/src/app/models/business/store_delivery_zone.dart';
import 'package:single_store_app/src/app/models/business/store_status.dart';

part 'initial_store.g.dart';

@immutable
@JsonSerializable()
class InitialStore  {
  const InitialStore({
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


  factory InitialStore.fromJson(Map<String, dynamic> json) =>
      _$InitialStoreFromJson(json);

  Map<String, dynamic> toJson() => _$InitialStoreToJson(this);

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
}
