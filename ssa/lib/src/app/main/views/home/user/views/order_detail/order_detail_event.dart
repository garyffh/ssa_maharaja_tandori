import 'package:single_store_app/src/app/models/order/trn_order_update.dart';
import 'package:single_store_app/src/app/models/order/trn_order_user_allocate_driver.dart';

abstract class OrderDetailEvent {
  OrderDetailEvent({required this.trnOrderId});

  final String trnOrderId;
}

class OrderDetailEventGetViewModel extends OrderDetailEvent {
  OrderDetailEventGetViewModel({
    required String trnOrderId,
  }) : super(trnOrderId: trnOrderId);
}

class OrderDetailEventOrderUpdate extends OrderDetailEvent {
  OrderDetailEventOrderUpdate({
    required String trnOrderId,
    required this.trnOrderUpdate,
  }) : super(trnOrderId: trnOrderId);

  final TrnOrderUpdate trnOrderUpdate;
}

class OrderDetailEventOrderDriverUpdate extends OrderDetailEvent {
  OrderDetailEventOrderDriverUpdate({
    required String trnOrderId,
    required this.trnOrderUserAllocateDriver,
  }) : super(trnOrderId: trnOrderId);

  final TrnOrderUserAllocateDriver trnOrderUserAllocateDriver;
}
