// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payment_method_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPaymentMethodAdd _$UserPaymentMethodAddFromJson(
        Map<String, dynamic> json) =>
    UserPaymentMethodAdd(
      identity: json['identity'] as String,
      token: json['token'] as String,
      status: json['status'] as String,
      responseMessage: json['responseMessage'] as String,
      hash: json['hash'] as String,
      cardId: json['cardId'] as String,
      ivrCardId: json['ivrCardId'] as String,
      cardKey: json['cardKey'] as String,
      custom1: json['custom1'] as String,
      custom2: json['custom2'] as String,
      custom3: json['custom3'] as String,
      customHash: json['customHash'] as String,
    );

Map<String, dynamic> _$UserPaymentMethodAddToJson(
        UserPaymentMethodAdd instance) =>
    <String, dynamic>{
      'identity': instance.identity,
      'token': instance.token,
      'status': instance.status,
      'responseMessage': instance.responseMessage,
      'hash': instance.hash,
      'cardId': instance.cardId,
      'ivrCardId': instance.ivrCardId,
      'cardKey': instance.cardKey,
      'custom1': instance.custom1,
      'custom2': instance.custom2,
      'custom3': instance.custom3,
      'customHash': instance.customHash,
    };
