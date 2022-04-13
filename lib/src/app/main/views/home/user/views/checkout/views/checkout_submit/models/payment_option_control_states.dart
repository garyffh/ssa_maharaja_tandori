import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_submit/models/payment_option_control_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_submit/models/payment_option_type.dart';
import 'package:single_store_app/src/app/models/checkout/trn_checkout_submit.dart';

class PaymentOptionControlStates {
  const PaymentOptionControlStates({
    required this.paymentOptionStates,
    required this.activePaymentOptionStates,
  });

  PaymentOptionControlStates.empty()
      : paymentOptionStates = List.empty(),
        activePaymentOptionStates = List.empty();

  PaymentOptionControlStates.fromTrnCheckoutSubmit(
      TrnCheckoutSubmit trnCheckoutSubmit)
      : paymentOptionStates = itemsFromPaymentOptionTypes(trnCheckoutSubmit),
        activePaymentOptionStates = getActivePaymentOptionStates(
            itemsFromPaymentOptionTypes(trnCheckoutSubmit));

  final List<PaymentOptionControlState> paymentOptionStates;
  final List<PaymentOptionControlState> activePaymentOptionStates;

  static List<PaymentOptionControlState> itemsFromPaymentOptionTypes(
      TrnCheckoutSubmit trnCheckoutSubmit) {
    return List<PaymentOptionControlState>.generate(
        PaymentOptionType.values.length, (int index) {
      switch (PaymentOptionType.values[index]) {
        case PaymentOptionType.paymentMethod:
          {
            return PaymentOptionControlState(
              paymentOptionType: PaymentOptionType.paymentMethod,
              isActive: !trnCheckoutSubmit.creditTransaction,
            );
          }

        case PaymentOptionType.redeem:
          {
            return PaymentOptionControlState(
              paymentOptionType: PaymentOptionType.redeem,
              isActive: trnCheckoutSubmit.hasRedemption,
            );
          }

        case PaymentOptionType.account:
          {
            return PaymentOptionControlState(
              paymentOptionType: PaymentOptionType.account,
              isActive: trnCheckoutSubmit.creditTransaction,
            );
          }
      }
    });
  }

  static List<PaymentOptionControlState> getActivePaymentOptionStates(
      List<PaymentOptionControlState> paymentOptionStates) {
    return paymentOptionStates.where((element) => element.isActive).toList();
  }
}
