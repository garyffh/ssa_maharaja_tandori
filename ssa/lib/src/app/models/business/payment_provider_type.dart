import 'package:json_annotation/json_annotation.dart';

enum PaymentProviderType {
  @JsonValue(0)
  none,
  @JsonValue(1)
  stripe,
}

extension PaymentProviderExtension on PaymentProviderType {
  String get text {
    switch (this) {
      case PaymentProviderType.none:
        return 'None';

      case PaymentProviderType.stripe:
        return 'Stripe';
    }
  }
}
