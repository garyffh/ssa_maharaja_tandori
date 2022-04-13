import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_state.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_order_billing.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_order_item.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_totals.dart';
import 'package:single_store_app/src/app/models/checkout/user_billing_client.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

part 'trn_checkout_order.g.dart';

@JsonSerializable()
@immutable
class TrnCheckoutOrder {
  const TrnCheckoutOrder({
    required this.identity,
    required this.documentId,
    required this.documentDate,
    required this.orderNumber,
    required this.pagerNumber,
    required this.version,
    required this.priceLevel,
    required this.adjustmentType,
    required this.adjustmentAmount,
    required this.storeDeliveryZoneId,
    required this.deliveryFee,
    required this.promotionRate,
    required this.promotionAmount,
    required this.promotionPoints,
    required this.deliveryPromotion,
    required this.totalEx,
    required this.taxAmount,
    required this.total,
    required this.spendPoints,
    required this.productPoints,
    required this.redeemPoints,
    required this.redeemCurrency,
    required this.storeStatusTime,
    required this.deliveryMethodType,
    required this.deliveryMethodAsap,
    required this.scheduledDeliveryMethodTime,
    required this.storePrepTime,
    required this.driverDeliveryTime,
    required this.orderComment,
    required this.billing,
    required this.items,
  });

  TrnCheckoutOrder.fromCheckoutSubmit({
    required this.identity,
    required UserBillingClient userBillingClient,
    required StoreStatusStateLoaded storeStatusState,
    required TrnCheckout trnCheckout,
    required TrnCheckoutTotals trnCheckoutTotals,
    required this.priceLevel,
    required this.storeDeliveryZoneId,
  })  : documentId = null,
        documentDate = null,
        orderNumber =
            trnCheckout.trnCheckoutDeliveryMethod!.checkoutTableNumber,
        pagerNumber = null,
        version = 3,
        adjustmentType = 0,
        adjustmentAmount = 0.0,
        deliveryFee = trnCheckout.trnCheckoutSubmit.hasDeliveryPromotion ? 0.0 : trnCheckout.trnCheckoutSubmit.deliveryFeeAmount,
        promotionRate = trnCheckout.trnCheckoutSubmit.promotionRate,
        promotionAmount = trnCheckout.trnCheckoutSubmit.promotionAmount,
        promotionPoints = 0,
        deliveryPromotion = trnCheckout.trnCheckoutSubmit.hasDeliveryPromotion,
        totalEx = trnCheckoutTotals.totalEx,
        taxAmount = trnCheckoutTotals.taxAmount,
        total = trnCheckoutTotals.total,
        spendPoints = 0,
        productPoints = 0,
        redeemPoints = trnCheckoutTotals.redeemPoints,
        redeemCurrency = trnCheckoutTotals.redeemCurrency,
        storeStatusTime =
            trnCheckout.trnCheckoutDeliveryMethod!.storeStatusTimeString,
        deliveryMethodType =
            trnCheckout.trnCheckoutDeliveryMethod!.deliveryMethodType,
        deliveryMethodAsap = trnCheckout.trnCheckoutDeliveryMethod!.isAsap,
        scheduledDeliveryMethodTime = trnCheckout
            .trnCheckoutDeliveryMethod!.scheduledDeliveryMethodTimeString,
        storePrepTime = storeStatusState.storeStatus.storeState.storePrepTime,
        driverDeliveryTime =
            storeStatusState.storeStatus.storeState.driverDeliveryTime,
        orderComment = null,
        billing = TrnCheckoutOrderBilling.fromCheckoutSubmit(
            trnCheckout, userBillingClient),
        items = [...trnCheckoutTotals.items];

  factory TrnCheckoutOrder.fromJson(Map<String, dynamic> json) =>
      _$TrnCheckoutOrderFromJson(json);

  Map<String, dynamic> toJson() => _$TrnCheckoutOrderToJson(this);

  final String identity;
  final String? documentId;
  final DateTime? documentDate;
  final String? orderNumber;
  final int? pagerNumber;
  final int version;
  final int priceLevel;
  final int adjustmentType;
  final double adjustmentAmount;
  final String? storeDeliveryZoneId;
  final double deliveryFee;
  final double promotionRate;
  final double promotionAmount;
  final int promotionPoints;
  final bool deliveryPromotion;
  final double totalEx;
  final double taxAmount;
  final double total;
  final int spendPoints;
  final int productPoints;
  final int redeemPoints;
  final double redeemCurrency;
  final String storeStatusTime;
  final DeliveryMethodType deliveryMethodType;
  final bool deliveryMethodAsap;
  final String? scheduledDeliveryMethodTime;
  final int storePrepTime;
  final int driverDeliveryTime;
  final String? orderComment;
  final TrnCheckoutOrderBilling billing;
  final List<TrnCheckoutOrderItem> items;
}
