import 'package:json_annotation/json_annotation.dart';

part 'user_payment_method_read.g.dart';

@JsonSerializable()
class UserPaymentMethodRead {
  UserPaymentMethodRead({
    required this.userPaymentMethodId,
    required this.typeId,
    required this.name,
    required this.defaultMethod,
  });

  factory UserPaymentMethodRead.fromJson(Map<String, dynamic> json) => _$UserPaymentMethodReadFromJson(json);
  Map<String, dynamic> toJson() => _$UserPaymentMethodReadToJson(this);

  final   String userPaymentMethodId;
  final   int typeId;
  final   String name;
  final   bool defaultMethod;

}
