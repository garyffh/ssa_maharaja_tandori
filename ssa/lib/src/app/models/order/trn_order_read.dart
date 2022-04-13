import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';

part 'trn_order_read.g.dart';

@JsonSerializable()
class TrnOrderRead {
  TrnOrderRead({
    required this.trnOrderId,
    required this.reference,
    required this.deliveryMethodType,
    required this.storeStatus,
    required this.deliveryMethodStatus,
    required this.orderDT,
    required this.scheduledStoreTime,
    required this.scheduledDeliveryMethodTime,
    required this.firstName,
    required this.lastName,
  });

  factory TrnOrderRead.fromJson(Map<String, dynamic> json) =>
      _$TrnOrderReadFromJson(json);

  Map<String, dynamic> toJson() => _$TrnOrderReadToJson(this);

  final String trnOrderId;
  final String reference;
  final DeliveryMethodType deliveryMethodType;
  final TrnOrderStoreStatus storeStatus;
  final TrnOrderDeliveryMethodStatus deliveryMethodStatus;
  final DateTime orderDT;
  final DateTime scheduledStoreTime;
  final DateTime scheduledDeliveryMethodTime;
  final String firstName;
  final String lastName;
}
