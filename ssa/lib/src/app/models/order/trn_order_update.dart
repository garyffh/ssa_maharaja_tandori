import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';

import 'delivery_method_type.dart';

part 'trn_order_update.g.dart';

@JsonSerializable()
class TrnOrderUpdate {
  TrnOrderUpdate({
    required this.method,
    required this.trnOrderId,
    required this.deliveryMethodType,
    required this.deliveryMethodStatus,
    required this.storeStatus,
    required this.deliveryMethodStatusDT,
    required this.storeStatusDT,
  });

  factory TrnOrderUpdate.fromJson(Map<String, dynamic> json) =>
      _$TrnOrderUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$TrnOrderUpdateToJson(this);

  final String method;
  final String trnOrderId;
  final String deliveryMethodType;
  final String deliveryMethodStatus;
  final String storeStatus;
  final DateTime deliveryMethodStatusDT;
  final DateTime storeStatusDT;

  DeliveryMethodType get orderDeliveryMethodType =>
      DeliveryMethodType.values[int.parse(deliveryMethodType)];

  TrnOrderDeliveryMethodStatus get orderDeliveryMethodStatus =>
      TrnOrderDeliveryMethodStatus.values[int.parse(deliveryMethodStatus)];

  TrnOrderStoreStatus get orderStoreStatus =>
      TrnOrderStoreStatus.values[int.parse(storeStatus)];

}
