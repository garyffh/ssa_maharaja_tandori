enum PaymentOptionType {
paymentMethod,
redeem,
account,
}

extension PaymentOptionTypeExtension on PaymentOptionType {

  String get text {
    switch(this) {

      case PaymentOptionType.paymentMethod:
        return 'CARD';

      case PaymentOptionType.redeem:
        return 'REDEEM POINTS';

      case PaymentOptionType.account:
        return 'TO ACCOUNT';


    }
  }


}
