// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payment_method_read.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPaymentMethodRead _$UserPaymentMethodReadFromJson(
        Map<String, dynamic> json) =>
    UserPaymentMethodRead(
      userPaymentMethodId: json['userPaymentMethodId'] as String,
      typeId: json['typeId'] as int,
      name: json['name'] as String,
      defaultMethod: json['defaultMethod'] as bool,
    );

Map<String, dynamic> _$UserPaymentMethodReadToJson(
        UserPaymentMethodRead instance) =>
    <String, dynamic>{
      'userPaymentMethodId': instance.userPaymentMethodId,
      'typeId': instance.typeId,
      'name': instance.name,
      'defaultMethod': instance.defaultMethod,
    };
