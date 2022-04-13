import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/constants/strings/trn_order_delivery_method_status.constants.dart';

enum TrnOrderDeliveryMethodStatus {
  @JsonValue(0)
  scheduled,
  @JsonValue(1)
  preparing,
  @JsonValue(2)
  readyForPickup,
  @JsonValue(3)
  delivering,
  @JsonValue(4)
  completed,
  @JsonValue(5)
  cancelled,
}

extension TrnOrderDeliveryMethodStatusExtension on TrnOrderDeliveryMethodStatus {

  String get text {
    switch(this) {

      case TrnOrderDeliveryMethodStatus.scheduled:
        return trnOrderDeliveryMethodStatusScheduledText;

      case TrnOrderDeliveryMethodStatus.preparing:
        return trnOrderDeliveryMethodStatusPreparingText;

      case TrnOrderDeliveryMethodStatus.readyForPickup:
        return trnOrderDeliveryMethodStatusReadForPickupText;

      case TrnOrderDeliveryMethodStatus.delivering:
        return trnOrderDeliveryMethodStatusDeliveringText;

      case TrnOrderDeliveryMethodStatus.completed:
        return trnOrderDeliveryMethodStatusCompletedText;

      case TrnOrderDeliveryMethodStatus.cancelled:
        return trnOrderDeliveryMethodStatusCancelledText;

    }
  }
}
