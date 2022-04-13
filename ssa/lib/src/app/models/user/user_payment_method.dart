import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';

part 'user_payment_method.g.dart';

@JsonSerializable()
class UserPaymentMethod {
  UserPaymentMethod({
    required this.updateId,
    required this.userPaymentMethodId,
    required this.typeId,
    required this.name,
    required this.hasSubscription,
    required this.defaultMethod,
    required this.failCount,

});

  factory UserPaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$UserPaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$UserPaymentMethodToJson(this);

  @Uint8ListConverter()
  Uint8List updateId;
  final String userPaymentMethodId;
  final int typeId;
  final String name;
  final bool hasSubscription;
  final bool defaultMethod;
  final int failCount;
}