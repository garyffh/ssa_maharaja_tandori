import 'package:single_store_app/src/app/infrastructure/formats.dart';

class TrnCheckoutSubmit {
  TrnCheckoutSubmit({
    required this.cartTotal,
    required this.promotionRate,
    required this.promotion,
    required this.hasPromotion,
    required this.promotionAmount,
    required this.promotionSubtotal,
    required this.hasDeliveryFee,
    required this.deliveryFeeAmount,
    required this.deliveryPromoEnabled,
    required this.deliveryPromo,
    required this.hasDeliveryPromotion,
    required this.deliveryPromotionAmount,
    required this.orderTotal,
    required this.redeemCurrencyAvailable,
    required this.orderRedeemCurrency,
    required this.orderRedeemPoints,
    required this.creditTransaction,
  });

  TrnCheckoutSubmit.initial()
      : cartTotal = 0.0,
        promotionRate = 0.0,
        promotion = false,
        hasPromotion = false,
        promotionAmount = 0.0,
        promotionSubtotal = 0.0,
        hasDeliveryFee = false,
        deliveryFeeAmount = 0.0,
        deliveryPromoEnabled = false,
        deliveryPromo = false,
        hasDeliveryPromotion = false,
        deliveryPromotionAmount = 0.0,
        orderTotal = 0.0,
        redeemCurrencyAvailable = 0.0,
        orderRedeemCurrency = 0.0,
        orderRedeemPoints = 0,
        creditTransaction = false;

  final double cartTotal;
  final double promotionRate;
  final bool promotion;
  final bool hasPromotion;
  final double promotionAmount;
  final double promotionSubtotal;
  final bool hasDeliveryFee;
  final double deliveryFeeAmount;
  final bool deliveryPromoEnabled;
  final bool deliveryPromo;
  final bool hasDeliveryPromotion;
  final double deliveryPromotionAmount;
  final double orderTotal;
  final double redeemCurrencyAvailable;
  final double orderRedeemCurrency;
  final int orderRedeemPoints;
  final bool creditTransaction;

  bool get hasRedemption => orderRedeemCurrency > 0.0 && !creditTransaction;

  bool get hasRedeemPayment =>  redeemPaymentTotal != 0.0;

  double get redeemPaymentTotal => orderTotal - orderRedeemCurrency;

  String get cartTotalLabel => 'Cart Total';

  String get promotionLabel => 'Promotion (-${Formats.qty(promotionRate)}%)';

  String get promotionSubtotalLabel => 'Subtotal';

  String get deliveryFeeLabel => 'Delivery';

  String get deliveryPromotionAmountLabel => 'Promotion (free delivery)';

  String get orderTotalLabel => 'Order Total';

  String get orderRedeemCurrencyLabel => 'Loyalty Point Redemption';

  String get paymentTotalLabel => creditTransaction ? 'To Account' : 'Payment';


}
