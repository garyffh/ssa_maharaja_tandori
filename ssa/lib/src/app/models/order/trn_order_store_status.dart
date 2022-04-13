import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/constants/strings/trn_order_store_status.constants.dart';

enum TrnOrderStoreStatus {
  @JsonValue(0)
  scheduled,
  @JsonValue(1)
  noDriver,
  @JsonValue(2)
  queued,
  @JsonValue(3)
  preparing,
  @JsonValue(4)
  waitingForPickup,
  @JsonValue(5)
  waitingForDelivery,
  @JsonValue(6)
  delivering,
  @JsonValue(7)
  completed,
  @JsonValue(8)
  cancelled,
}


extension TrnOrderStoreStatusExtension on TrnOrderStoreStatus {

  String get text {
    switch(this) {

      case TrnOrderStoreStatus.scheduled:
        return trnOrderStoreStatusScheduledText;

      case TrnOrderStoreStatus.noDriver:
        return trnOrderStoreStatusNoDriverText;

      case TrnOrderStoreStatus.queued:
        return trnOrderStoreStatusQueuedText;

      case TrnOrderStoreStatus.preparing:
        return trnOrderStoreStatusPreparingText;

      case TrnOrderStoreStatus.waitingForPickup:
        return trnOrderStoreStatusWaitingForPickupText;

      case TrnOrderStoreStatus.waitingForDelivery:
        return trnOrderStoreStatusWaitingForDeliveryText;

      case TrnOrderStoreStatus.delivering:
        return trnOrderStoreStatusDeliveringText;

      case TrnOrderStoreStatus.completed:
        return trnOrderStoreStatusCompletedText;

      case TrnOrderStoreStatus.cancelled:
        return trnOrderStoreStatusCancelledText;

    }
  }


}
