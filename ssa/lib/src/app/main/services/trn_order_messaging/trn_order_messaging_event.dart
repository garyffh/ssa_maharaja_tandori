import 'package:single_store_app/src/app/models/order/trn_order_update.dart';

class TrnOrderMessagingStateEvent {
  TrnOrderMessagingStateEvent({
    required this.trnOrderUpdate,
});

  final TrnOrderUpdate trnOrderUpdate;

}

