import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/double_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/string_extensions.dart';
import 'package:single_store_app/src/app/models/cart/cart.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_address.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_delivery_method.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_payment_method.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_phone.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_submit.dart';
import 'package:single_store_app/src/app/models/checkout/user_billing_client.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

@immutable
class TrnCheckout {
  const TrnCheckout({
    required this.trnCheckoutDeliveryMethod,
    required this.trnCheckoutAddress,
    required this.trnCheckoutPhone,
    required this.trnCheckoutPaymentMethod,
    required this.trnCheckoutSubmit,
  });

  TrnCheckout.initial()
      : trnCheckoutDeliveryMethod = null,
        trnCheckoutAddress = null,
        trnCheckoutPhone = null,
        trnCheckoutPaymentMethod = TrnCheckoutPaymentMethod.initial(),
        trnCheckoutSubmit = TrnCheckoutSubmit.initial();

  TrnCheckout.updateFromUserBillingClient(
    TrnCheckout trnCheckout,
    Cart cart,
    UserBillingClient userBillingClient,
    BusinessSettingsStateLoaded businessSettings,
  )   : trnCheckoutDeliveryMethod = trnCheckout.trnCheckoutDeliveryMethod,
        trnCheckoutAddress =
            trnCheckoutAddressFromUserBillingClient(userBillingClient),
        trnCheckoutPhone = (userBillingClient.phoneNumber == null ||
                userBillingClient.phoneNumberConfirmed == null)
            ? null
            : trnCheckoutPhoneFromUserBillingClient(userBillingClient),
        trnCheckoutPaymentMethod =
            trnCheckoutPaymentMethodFromUserBillingClient(userBillingClient),
        trnCheckoutSubmit = trnCheckoutSubmitFromUserBillingClient(
          cart: cart,
          userBillingClient: userBillingClient,
          businessSettings: businessSettings,
        );

  TrnCheckout.updateTrnCheckoutDeliveryMethod(
      TrnCheckout trnCheckout,
      Cart cart,
      UserBillingClient userBillingClient,
      BusinessSettingsStateLoaded businessSettings,
      this.trnCheckoutDeliveryMethod)
      : trnCheckoutAddress = trnCheckout.trnCheckoutAddress,
        trnCheckoutPhone = trnCheckout.trnCheckoutPhone,
        trnCheckoutPaymentMethod = trnCheckout.trnCheckoutPaymentMethod,
        trnCheckoutSubmit = trnCheckoutSubmitUpdate(
          cart: cart,
          userBillingClient: userBillingClient,
          businessSettings: businessSettings,
          trnCheckoutDeliveryMethod: trnCheckoutDeliveryMethod,
          trnCheckoutAddress: trnCheckout.trnCheckoutAddress,
        );

  TrnCheckout.updateTrnCheckoutAddress(
    TrnCheckout trnCheckout,
    Cart cart,
    UserBillingClient userBillingClient,
    BusinessSettingsStateLoaded businessSettings,
    this.trnCheckoutAddress,
  )   : trnCheckoutDeliveryMethod = trnCheckout.trnCheckoutDeliveryMethod,
        trnCheckoutPhone = trnCheckout.trnCheckoutPhone,
        trnCheckoutPaymentMethod = trnCheckout.trnCheckoutPaymentMethod,
        trnCheckoutSubmit = trnCheckoutSubmitUpdate(
          cart: cart,
          userBillingClient: userBillingClient,
          businessSettings: businessSettings,
          trnCheckoutDeliveryMethod: trnCheckout.trnCheckoutDeliveryMethod,
          trnCheckoutAddress: trnCheckoutAddress,
        );

  TrnCheckout.updateTrnCheckoutPhone(
      TrnCheckout trnCheckout, this.trnCheckoutPhone)
      : trnCheckoutDeliveryMethod = trnCheckout.trnCheckoutDeliveryMethod,
        trnCheckoutAddress = trnCheckout.trnCheckoutAddress,
        trnCheckoutPaymentMethod = trnCheckout.trnCheckoutPaymentMethod,
        trnCheckoutSubmit = trnCheckout.trnCheckoutSubmit;

  TrnCheckout.updateTrnCheckoutPaymentMethod(
      TrnCheckout trnCheckout, this.trnCheckoutPaymentMethod)
      : trnCheckoutDeliveryMethod = trnCheckout.trnCheckoutDeliveryMethod,
        trnCheckoutAddress = trnCheckout.trnCheckoutAddress,
        trnCheckoutPhone = trnCheckout.trnCheckoutPhone,
        trnCheckoutSubmit = trnCheckout.trnCheckoutSubmit;

  final TrnCheckoutDeliveryMethod? trnCheckoutDeliveryMethod;
  final TrnCheckoutAddress? trnCheckoutAddress;
  final TrnCheckoutPhone? trnCheckoutPhone;
  final TrnCheckoutPaymentMethod trnCheckoutPaymentMethod;
  final TrnCheckoutSubmit trnCheckoutSubmit;

  static TrnCheckoutAddress? trnCheckoutAddressFromUserBillingClient(
      UserBillingClient userBillingClient) {
    if (userBillingClient.street == null ||
        userBillingClient.locality == null ||
        userBillingClient.region == null ||
        userBillingClient.postalCode == null ||
        userBillingClient.country == null) {
      return null;
    } else {
      return TrnCheckoutAddress.fromUserBillingClient(userBillingClient);
    }
  }

  static TrnCheckoutPhone trnCheckoutPhoneFromUserBillingClient(
      UserBillingClient userBillingClient) {

    return TrnCheckoutPhone(
      phoneNumber: userBillingClient.phoneNumber!,
      phoneNumberConfirmed: userBillingClient.phoneNumberConfirmed!,
    );
  }

  static TrnCheckoutPaymentMethod trnCheckoutPaymentMethodFromUserBillingClient(
      UserBillingClient userBillingClient) {

    return TrnCheckoutPaymentMethod(
      paymentMethods: [...userBillingClient.paymentMethods],
      selectedPaymentMethod: userBillingClient.paymentMethods
          .firstWhereOrNull((element) => element.defaultMethod),
      creditTransaction: userBillingClient.allowCreditTransaction,
    );
  }

  static TrnCheckoutSubmit trnCheckoutSubmitUpdate({
    required Cart cart,
    required UserBillingClient userBillingClient,
    required BusinessSettingsStateLoaded businessSettings,
    required TrnCheckoutDeliveryMethod? trnCheckoutDeliveryMethod,
    required TrnCheckoutAddress? trnCheckoutAddress,
  }) {

    final bool hasPromotion =
        !userBillingClient.promoTaken && businessSettings.promoRate > 0.0;

    final double promotionAmount = hasPromotion
        ? -(cart.cartTotals.total * (businessSettings.promoRate / 100.0))
            .roundDown(2)
        : 0.0;
    final double promotionSubtotal = hasPromotion
        ? cart.cartTotals.total + promotionAmount
        : cart.cartTotals.total;

    final bool hasDeliveryFee = businessSettings.hasDeliveryFee(
        trnCheckoutDeliveryMethod, trnCheckoutAddress);

    final double deliveryFeeAmount = businessSettings.deliveryFeeAmount(
        trnCheckoutDeliveryMethod, trnCheckoutAddress);

    final bool hasDeliveryPromotion = businessSettings.deliveryPromoEnabled &&
        deliveryFeeAmount > 0.0 &&
        !userBillingClient.deliveryTaken;
    final double deliveryPromotionAmount =
        hasDeliveryPromotion ? -deliveryFeeAmount : 0;

    final double orderTotal =
        cart.cartTotals.total + promotionAmount + deliveryFeeAmount + deliveryPromotionAmount;

    double redeemCurrencyAvailable = 0.0;
    if (userBillingClient.points > 0 &&
        businessSettings.pointRedemptionRatio > 0) {
      final double tmpAmount =
          (userBillingClient.points / businessSettings.pointRedemptionRatio)
                  .floor() /
              100.0;
      if (tmpAmount >= 3.0) {
        redeemCurrencyAvailable = tmpAmount;
      }
    }
    double orderRedeemCurrency = 0.0;
    if (redeemCurrencyAvailable >= promotionSubtotal) {
      orderRedeemCurrency = promotionSubtotal;
    } else {
      if ((promotionSubtotal - redeemCurrencyAvailable) >
          businessSettings.minimumEftpos) {
        orderRedeemCurrency = redeemCurrencyAvailable;
      } else {
        if(redeemCurrencyAvailable >= promotionSubtotal - businessSettings.minimumEftpos) {
          orderRedeemCurrency = promotionSubtotal - businessSettings.minimumEftpos;
        }
      }
    }

    int orderRedeemPoints = 0;
    if (orderRedeemCurrency > 0.0) {
      orderRedeemPoints = (orderRedeemCurrency * 100.0).toInt() *
          businessSettings.pointRedemptionRatio;
    }

    return TrnCheckoutSubmit(
      cartTotal: cart.cartTotals.total,
      promotionRate: businessSettings.promoRate,
      promotion: !userBillingClient.promoTaken,
      hasPromotion: hasPromotion,
      promotionAmount: promotionAmount,
      promotionSubtotal: promotionSubtotal,
      hasDeliveryFee: hasDeliveryFee,
      deliveryFeeAmount: deliveryFeeAmount,
      deliveryPromoEnabled: businessSettings.deliveryPromoEnabled,
      deliveryPromo: !userBillingClient.deliveryTaken,
      hasDeliveryPromotion: hasDeliveryPromotion,
      deliveryPromotionAmount: deliveryPromotionAmount,
      orderTotal: orderTotal,
      redeemCurrencyAvailable: redeemCurrencyAvailable,
      orderRedeemCurrency: orderRedeemCurrency,
      orderRedeemPoints: orderRedeemPoints,
      creditTransaction: userBillingClient.allowCreditTransaction,
    );
  }

  static TrnCheckoutSubmit trnCheckoutSubmitFromUserBillingClient({
    required Cart cart,
    required UserBillingClient userBillingClient,
    required BusinessSettingsStateLoaded businessSettings,
  }) {
    return trnCheckoutSubmitUpdate(
      cart: cart,
      userBillingClient: userBillingClient,
      businessSettings: businessSettings,
      trnCheckoutDeliveryMethod: null,
      trnCheckoutAddress:
          trnCheckoutAddressFromUserBillingClient(userBillingClient),
    );
  }

  bool get showPaymentMethodStep {
    if (trnCheckoutAddress == null) {
      return false;
    } else {
      if (trnCheckoutAddress!.street.isNullOrEmpty ||
          trnCheckoutAddress!.locality.isNullOrEmpty ||
          trnCheckoutAddress!.region.isNullOrEmpty ||
          trnCheckoutAddress!.postalCode.isNullOrEmpty ||
          trnCheckoutAddress!.country.isNullOrEmpty) {
        return false;
      } else {
        return true;
      }
    }
  }

  bool get hasAddress {
    if (trnCheckoutAddress == null) {
      return false;
    } else {
      if (trnCheckoutAddress!.street.isNullOrEmpty ||
          trnCheckoutAddress!.locality.isNullOrEmpty ||
          trnCheckoutAddress!.region.isNullOrEmpty ||
          trnCheckoutAddress!.postalCode.isNullOrEmpty ||
          trnCheckoutAddress!.country.isNullOrEmpty) {
        return false;
      } else {
        return true;
      }
    }
  }

  bool validAddressDistance(double maxDeliveryDistance) {
    if (trnCheckoutAddress != null && trnCheckoutDeliveryMethod != null) {
      if (trnCheckoutAddress!.distance != null &&
          trnCheckoutDeliveryMethod!.deliveryMethodType != null) {
        if (trnCheckoutDeliveryMethod!.deliveryMethodType ==
                DeliveryMethodType.delivery ||
            trnCheckoutDeliveryMethod!.deliveryMethodType ==
                DeliveryMethodType.period) {
          return trnCheckoutAddress!.distance! <= maxDeliveryDistance;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  bool get hasPhone {
    if (trnCheckoutPhone == null) {
      return false;
    } else {
      return true;
    }
  }

  bool get hasPaymentMethod {
    return trnCheckoutPaymentMethod.paymentMethods.isNotEmpty;
  }
}
