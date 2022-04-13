// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentProvider _$PaymentProviderFromJson(Map<String, dynamic> json) =>
    PaymentProvider(
      paymentProviderType: $enumDecode(
          _$PaymentProviderTypeEnumMap, json['paymentProviderType']),
      paymentKey: json['paymentKey'] as String,
      merchantIdentifier: json['merchantIdentifier'] as String,
      defaultProvider: json['defaultProvider'] as bool,
      available: json['available'] as bool,
    );

Map<String, dynamic> _$PaymentProviderToJson(PaymentProvider instance) =>
    <String, dynamic>{
      'paymentProviderType':
          _$PaymentProviderTypeEnumMap[instance.paymentProviderType],
      'paymentKey': instance.paymentKey,
      'merchantIdentifier': instance.merchantIdentifier,
      'defaultProvider': instance.defaultProvider,
      'available': instance.available,
    };

const _$PaymentProviderTypeEnumMap = {
  PaymentProviderType.none: 0,
  PaymentProviderType.stripe: 1,
};
