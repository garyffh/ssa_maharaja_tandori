// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPaymentMethod _$UserPaymentMethodFromJson(Map<String, dynamic> json) =>
    UserPaymentMethod(
      updateId: const Uint8ListConverter().fromJson(json['updateId'] as String),
      userPaymentMethodId: json['userPaymentMethodId'] as String,
      typeId: json['typeId'] as int,
      name: json['name'] as String,
      hasSubscription: json['hasSubscription'] as bool,
      defaultMethod: json['defaultMethod'] as bool,
      failCount: json['failCount'] as int,
    );

Map<String, dynamic> _$UserPaymentMethodToJson(UserPaymentMethod instance) =>
    <String, dynamic>{
      'updateId': const Uint8ListConverter().toJson(instance.updateId),
      'userPaymentMethodId': instance.userPaymentMethodId,
      'typeId': instance.typeId,
      'name': instance.name,
      'hasSubscription': instance.hasSubscription,
      'defaultMethod': instance.defaultMethod,
      'failCount': instance.failCount,
    };
