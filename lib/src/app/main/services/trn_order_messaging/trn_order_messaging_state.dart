import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/models/order/trn_order_update.dart';

@immutable
class TrnOrderMessagingState  {
  const TrnOrderMessagingState({
    this.trnOrderUpdate,
  }) : super();

  final TrnOrderUpdate? trnOrderUpdate;
}

