import 'package:single_store_app/src/app/main/views/home/user/views/checkout/views/checkout_submit/models/payment_option_type.dart';

class PaymentOptionControlState  {
  const PaymentOptionControlState({
    required this.paymentOptionType,
    required this.isActive,
  });

  final PaymentOptionType paymentOptionType;
  final bool isActive;

}
