import 'package:json_annotation/json_annotation.dart';

part 'user_payment_method_add.g.dart';

@JsonSerializable()
class UserPaymentMethodAdd {
  UserPaymentMethodAdd({
    required this.identity,
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

  factory UserPaymentMethodAdd.fromJson(Map<String, dynamic> json) =>
      _$UserPaymentMethodAddFromJson(json);

  Map<String, dynamic> toJson() => _$UserPaymentMethodAddToJson(this);

  final String identity;
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
