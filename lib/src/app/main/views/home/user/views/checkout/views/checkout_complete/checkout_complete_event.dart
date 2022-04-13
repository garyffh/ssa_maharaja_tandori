import 'package:single_store_app/src/app/models/order/trn_order.dart';
import 'package:single_store_app/src/app/models/order/trn_order_update.dart';
import 'package:single_store_app/src/app/models/order/trn_order_user_allocate_driver.dart';

abstract class CheckoutCompleteEvent {
  CheckoutCompleteEvent({required this.trnOrderId});

  final String trnOrderId;
}

class CheckoutCompleteEventGetViewModel extends CheckoutCompleteEvent {
  CheckoutCompleteEventGetViewModel({
    required this.trnOrder,
  }) : super(trnOrderId: trnOrder.trnOrderId);

  final TrnOrder trnOrder;
}

class CheckoutCompleteEventUpdate extends CheckoutCompleteEvent {
  CheckoutCompleteEventUpdate({
    required String trnOrderId,
    required this.trnOrderUpdate,
  }) : super(trnOrderId: trnOrderId);

  final TrnOrderUpdate trnOrderUpdate;
}

class CheckoutCompleteEventDriverUpdate extends CheckoutCompleteEvent {
  CheckoutCompleteEventDriverUpdate({
    required String trnOrderId,
    required this.trnOrderUserAllocateDriver,
  }) : super(trnOrderId: trnOrderId);

  final TrnOrderUserAllocateDriver trnOrderUserAllocateDriver;
}
