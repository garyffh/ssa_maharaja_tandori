import 'package:single_store_app/src/app/models/order/trn_order_update.dart';

abstract class DriverDeliveryDetailEvent {
  DriverDeliveryDetailEvent({required this.trnOrderId});

  final String trnOrderId;
}

class DriverDeliveryDetailEventGetViewModel extends DriverDeliveryDetailEvent {
  DriverDeliveryDetailEventGetViewModel({required String trnOrderId})
      : super(trnOrderId: trnOrderId);
}

class DriverDeliveryDetailEventPickedUp extends DriverDeliveryDetailEvent {
  DriverDeliveryDetailEventPickedUp({required String trnOrderId})
      : super(trnOrderId: trnOrderId);
}

class DriverDeliveryDetailEventDelivered extends DriverDeliveryDetailEvent {
  DriverDeliveryDetailEventDelivered({required String trnOrderId})
      : super(trnOrderId: trnOrderId);
}

class DriverDeliveryDetailEventOrderUpdate extends DriverDeliveryDetailEvent {
  DriverDeliveryDetailEventOrderUpdate({
    required String trnOrderId,
    required this.trnOrderUpdate,
  }) : super(trnOrderId: trnOrderId);

  final TrnOrderUpdate trnOrderUpdate;
}
