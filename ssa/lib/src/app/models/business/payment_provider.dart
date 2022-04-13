import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/business/payment_provider_type.dart';

part 'payment_provider.g.dart';

@immutable
@JsonSerializable()
class PaymentProvider {
  const PaymentProvider({
    required this.paymentProviderType,
    required this.paymentKey,
    required this.merchantIdentifier,
    required this.defaultProvider,
    required this.available,
  });

  PaymentProvider.unavailable(PaymentProvider paymentProvider)
      : paymentProviderType = paymentProvider.paymentProviderType,
        paymentKey = paymentProvider.paymentKey,
        merchantIdentifier = paymentProvider.merchantIdentifier,
        defaultProvider = paymentProvider.defaultProvider,
        available = false;

  PaymentProvider.clone(PaymentProvider paymentProvider)
      : paymentProviderType = paymentProvider.paymentProviderType,
        paymentKey = paymentProvider.paymentKey,
        merchantIdentifier = paymentProvider.merchantIdentifier,
        defaultProvider = paymentProvider.defaultProvider,
        available = paymentProvider.available;

  const PaymentProvider.empty({ required this.paymentProviderType})
      : paymentKey = '',
        merchantIdentifier = '',
        defaultProvider = false,
        available = false;

  factory PaymentProvider.fromJson(Map<String, dynamic> json) =>
      _$PaymentProviderFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentProviderToJson(this);

  final PaymentProviderType paymentProviderType;
  final String paymentKey;
  final String merchantIdentifier;
  final bool defaultProvider;
  final bool available;

  static List<PaymentProvider> paymentProviderList(
      List<PaymentProvider> apiPaymentProviders) {
    return List<PaymentProvider>.generate(PaymentProviderType.values.length,
        (index) {
      final PaymentProvider? apiPaymentProvider =
          apiPaymentProviders.firstWhereOrNull(
        (element) =>
            element.paymentProviderType == PaymentProviderType.values[index],
      );

      if (apiPaymentProvider == null) {
        return PaymentProvider.empty(
          paymentProviderType: PaymentProviderType.values[index],
        );
      } else {
        return PaymentProvider.clone(apiPaymentProvider);
      }
    });
  }
}
