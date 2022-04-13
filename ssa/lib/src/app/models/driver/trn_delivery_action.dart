import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';

part 'trn_delivery_action.g.dart';

@JsonSerializable()
class TrnDeliveryAction {
  TrnDeliveryAction({
    required this.updateId,
    required this.trnOrderId,
    required this.deliveryMethodStatus,
    required this.storeStatus,
    required this.deliveryMethodStatusDT,
    required this.storeStatusDT,
  });

  factory TrnDeliveryAction.fromJson(Map<String, dynamic> json) => _$TrnDeliveryActionFromJson(json);
  Map<String, dynamic> toJson() => _$TrnDeliveryActionToJson(this);

  @Uint8ListConverter()
  final   Uint8List updateId;
  final   String trnOrderId;
  final   TrnOrderDeliveryMethodStatus deliveryMethodStatus;
  final   TrnOrderStoreStatus storeStatus;
  final   DateTime deliveryMethodStatusDT;
  final   DateTime storeStatusDT;

}
