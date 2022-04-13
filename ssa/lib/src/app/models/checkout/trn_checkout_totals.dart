import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_submit/models/checkout_submit_method.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_submit/models/payment_option_type.dart';
import 'package:single_store_app/src/app/models/cart/cart.dart';
import 'package:single_store_app/src/app/models/cart/cart_active_item.dart';
import 'package:single_store_app/src/app/models/cart/cart_condiment_table_item.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_order_item.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_submit.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';

@immutable
class TrnCheckoutTotals {
  const TrnCheckoutTotals({
    required this.totalEx,
    required this.taxAmount,
    required this.total,
    required this.redeemPoints,
    required this.redeemCurrency,
    required this.items,
  });

  factory TrnCheckoutTotals.fromCheckoutSubmit({
    required BusinessSettingsStateLoaded businessSettings,
    required Cart cart,
    required TrnCheckoutSubmit trnCheckoutSubmit,
    required CheckoutSubmitMethod checkoutSubmitMethod,
  }) {
    double orderTotal = 0.0;
    double orderTotalEx = 0.0;

    final List<TrnCheckoutOrderItem> items = List.empty(growable: true);
    int itemNumber = 1;
    for (final CartActiveItem cartActiveItem in cart.cartActive.items) {
      final double totalExTax = businessSettings.totalExFromTotalInc(
          cartActiveItem.total, cartActiveItem.tax != 0);
      orderTotal += cartActiveItem.total;
      orderTotalEx += totalExTax;

      items.add(TrnCheckoutOrderItem.fromCartActiveItem(
        itemNumber: itemNumber++,
        totalExTax: totalExTax,
        cartActiveItem: cartActiveItem,
      ));

      if (cartActiveItem.cartActiveChain != null) {
        final List<CartCondimentTableItem> cartCondimentTableItems =
            cartActiveItem.cartActiveChain!.selectedItems;
        for (final CartCondimentTableItem cartCondimentTableItem
            in cartCondimentTableItems) {
          final double totalExTax = businessSettings.totalExFromTotalInc(
              cartCondimentTableItem.total, cartCondimentTableItem.tax != 0);
          orderTotal += cartCondimentTableItem.total;
          orderTotalEx += totalExTax;

          items.add(TrnCheckoutOrderItem.fromCartCondimentTableItem(
            itemNumber: itemNumber++,
            totalExTax: totalExTax,
            cartCondimentTableItem: cartCondimentTableItem,
          ));
        }
      }

      if (cartActiveItem.instructions != null) {
        items.add(TrnCheckoutOrderItem.fromInstructions(
          itemNumber: itemNumber++,
          instructions: cartActiveItem.instructions!,
        ));
      }
    }

    final double promotionExTax = businessSettings.totalExFromTotalInc(trnCheckoutSubmit.promotionAmount, true);
    final double deliveryExTax = businessSettings.totalExFromTotalInc(trnCheckoutSubmit.deliveryFeeAmount, true);

    orderTotal += trnCheckoutSubmit.promotionAmount + trnCheckoutSubmit.deliveryFeeAmount + trnCheckoutSubmit.deliveryPromotionAmount;
    orderTotalEx += promotionExTax + deliveryExTax;

    if (orderTotal != trnCheckoutSubmit.orderTotal) {
      throw AppException.fromString('Error calculating the order total!');
    }

    return TrnCheckoutTotals(
      totalEx: orderTotalEx,
      taxAmount: orderTotal - orderTotalEx,
      total: orderTotal,
      redeemPoints:
          checkoutSubmitMethod.paymentOptionType == PaymentOptionType.redeem
              ? trnCheckoutSubmit.orderRedeemPoints
              : 0,
      redeemCurrency:
          checkoutSubmitMethod.paymentOptionType == PaymentOptionType.redeem
              ? trnCheckoutSubmit.orderRedeemCurrency
              : 0.0,
      items: items,
    );
  }

  final double totalEx;
  final double taxAmount;
  final double total;
  final int redeemPoints;
  final double redeemCurrency;
  final List<TrnCheckoutOrderItem> items;
}
