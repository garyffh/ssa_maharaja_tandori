import 'package:json_annotation/json_annotation.dart';

part 'checkout_payment_method_add.g.dart';

@JsonSerializable()
class CheckoutPaymentMethodAdd {
  CheckoutPaymentMethodAdd({
    required this.token,
    required this.status,
    required this.responseMessage,
    required this.hash,
    required this.cardId,
    required this.ivrCardId,
    required this.cardKey,
    required this.custom1,
    required this.custom2,
    required this.custom3,
    required this.customHash,
  });

  factory CheckoutPaymentMethodAdd.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPaymentMethodAddFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutPaymentMethodAddToJson(this);

  final String token;
  final String status;
  final String responseMessage;
  final String hash;
  final String cardId;
  final String ivrCardId;
  final String cardKey;
  final String custom1;
  final String custom2;
  final String custom3;
  final String customHash;
}
