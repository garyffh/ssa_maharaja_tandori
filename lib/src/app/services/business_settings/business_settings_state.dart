import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/double_extensions.dart';
import 'package:single_store_app/src/app/models/business/payment_provider.dart';
import 'package:single_store_app/src/app/models/business/store_category_read.dart';
import 'package:single_store_app/src/app/models/business/store_delivery_zone.dart';
import 'package:single_store_app/src/app/models/business/store_status.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_address.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_delivery_method.dart';
import 'package:single_store_app/src/app/models/multi_store/store_settings.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

enum BusinessSettingStateType { pending, loaded }


@immutable
abstract class BusinessSettingsState {
  const BusinessSettingsState({
    required this.type,
  });

  final BusinessSettingStateType type;

  String get identity => '';
  bool get multiStore => false;
  int get activePriceLevel => 1;
  bool get appSignInRequired => false;
  String get imagesPath => '';
  String get productImagePath => '';
  String get deliveryAreaPath => '';
  bool get paymentGatewayAvailable => false;

}

class BusinessSettingsStatePending extends BusinessSettingsState {
  const BusinessSettingsStatePending()
      : super(type: BusinessSettingStateType.pending);
}

class BusinessSettingsStateLoaded extends BusinessSettingsState {
  const BusinessSettingsStateLoaded({
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
    required this.paymentProviders,
    required this.storeDeliveryZones,
    required this.storeCategories,
    required this.storeStatus,
  }) : super(type: BusinessSettingStateType.loaded);


  BusinessSettingsStateLoaded.fromStoreSetting({
    required StoreSettings storeSettings,
    required this.paymentProviders,
  })
      : isMultiStore = storeSettings.isMultiStore,
        businessIdentity = storeSettings.businessIdentity,
        businessName = storeSettings.businessName,
        companyNumber = storeSettings.companyNumber,
        taxRate = storeSettings.taxRate,
        phone = storeSettings.phone,
        email = storeSettings.email,
        street = storeSettings.street,
        extended = storeSettings.extended,
        locality = storeSettings.locality,
        region = storeSettings.region,
        postalCode = storeSettings.postalCode,
        country = storeSettings.country,
        latitude = storeSettings.latitude,
        longitude = storeSettings.longitude,
        timeZone = storeSettings.timeZone,
        deliveryDistance = storeSettings.deliveryDistance,
        topMenuCategories = storeSettings.topMenuCategories,
        priceLevel = storeSettings.priceLevel,
        pointRedemptionRatio = storeSettings.pointRedemptionRatio,
        cardReadTypeId = storeSettings.cardReadTypeId,
        minOrder = storeSettings.minOrder,
        deliveryFee = storeSettings.deliveryFee,
        minimumEftpos =
        storeSettings.minimumEftpos < .5 ? .5 : storeSettings.minimumEftpos,
        tableService = storeSettings.tableService,
        googleApiKey = storeSettings.googleApiKey,
        theme = storeSettings.theme,
        newAccounts = storeSettings.newAccounts,
        promoRate = storeSettings.promoRate,
        deliveryPromoEnabled = storeSettings.deliveryPromoEnabled,
        useDeliveryPeriods = storeSettings.useDeliveryPeriods,
        signInRequired = storeSettings.signInRequired,
        storeDeliveryZones = storeSettings.storeDeliveryZones,
        storeCategories = storeSettings.storeCategories,
        storeStatus = storeSettings.storeStatus,
        super(type: BusinessSettingStateType.loaded);

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

  final List<PaymentProvider> paymentProviders;
  final List<StoreDeliveryZone> storeDeliveryZones;
  final List<StoreCategoryRead> storeCategories;
  final StoreStatus storeStatus;

  @override
  bool get paymentGatewayAvailable => paymentProviders.isNotEmpty;

  @override
  bool get multiStore => isMultiStore;

  @override
  String get identity => businessIdentity;

  @override
  int get activePriceLevel => priceLevel;

  @override
  bool get appSignInRequired => signInRequired;

  @override
  String get imagesPath => isMultiStore ? 'assets/ffh/$businessIdentity/images' : 'assets/ffh/images';

  @override
  String get productImagePath => isMultiStore ? 'assets/ffh/$businessIdentity/products' : 'assets/ffh/products';

  @override
  String get deliveryAreaPath => isMultiStore ? 'app-delivery-areas/$businessIdentity' : 'app-delivery-areas';

  bool get usesDeliveryZones => storeDeliveryZones.isNotEmpty;

  double get maxDeliveryDistance {
    if (storeDeliveryZones.isNotEmpty) {
      return storeDeliveryZones[storeDeliveryZones.length - 1].deliveryDistance;
    } else {
      return deliveryDistance;
    }
  }

  StoreDeliveryZone? getDeliveryZone(double? distance) {
    if(distance == null) {
      return null;
    }

    if (distance < 0.0) {
      return null;
    }

    if (storeDeliveryZones.isEmpty) {
      return null;
    }

    if (distance > maxDeliveryDistance) {
      return null;
    }

    StoreDeliveryZone? rtn;

    for (final element in storeDeliveryZones) {
      if (distance <= element.deliveryDistance) {
        rtn = element.copyWith();
        break;
      }
    }

    return rtn;
  }

  String? storeDeliveryZoneId(double? distance) {
    final StoreDeliveryZone? storeDeliveryZone = getDeliveryZone(distance);
    if(storeDeliveryZone == null) {
      return null;
    } else {
      return storeDeliveryZone.storeDeliveryZoneId;
    }

  }

  double deliveryFeeAmount(TrnCheckoutDeliveryMethod? trnCheckoutDeliveryMethod,
      TrnCheckoutAddress? trnCheckoutAddress) {
    if (trnCheckoutDeliveryMethod != null && trnCheckoutAddress != null) {
      if (trnCheckoutAddress.distance != null &&
          trnCheckoutDeliveryMethod.deliveryMethodType != null) {
        if (trnCheckoutAddress.distance! >= 0.0) {
          if (trnCheckoutDeliveryMethod.deliveryMethodType ==
                  DeliveryMethodType.delivery ||
              trnCheckoutDeliveryMethod.deliveryMethodType ==
                  DeliveryMethodType.period) {
            if (usesDeliveryZones) {
              final StoreDeliveryZone? storeDeliveryZone =
                  getDeliveryZone(trnCheckoutAddress.distance);

              if (storeDeliveryZone == null) {
                return 0.0;
              } else {
                return storeDeliveryZone.deliveryFee > 0.0
                    ? storeDeliveryZone.deliveryFee
                    : 0.0;
              }
            } else {
              return deliveryFee > 0.0 ? deliveryFee : 0.0;
            }
          } else {
            return 0.0;
          }
        } else {
          return 0.0;
        }
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  bool hasDeliveryFee(TrnCheckoutDeliveryMethod? trnCheckoutDeliveryMethod,
      TrnCheckoutAddress? trnCheckoutAddress) {
    return deliveryFeeAmount(trnCheckoutDeliveryMethod, trnCheckoutAddress) !=
        0.0;
  }

  double totalExFromTotalInc(double totalInc, bool taxable) {
    if(taxable) {
      return (totalInc / (1.0 + (taxRate / 100.0))).roundDown(2);
    } else {
      return totalInc;
    }
  }
}
