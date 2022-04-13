import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';

part 'trn_delivery_read.g.dart';

@JsonSerializable()
class TrnDeliveryRead {
  TrnDeliveryRead({
    required this.updateId,
    required this.trnOrderId,
    required this.reference,
    required this.storeStatus,
    required this.deliveryMethodStatus,
    required this.scheduledStoreTime,
    required this.scheduledDeliveryMethodTime,
    required this.deliveryMethodAsap,
    required this.firstName,
    required this.lastName,
  });

  factory TrnDeliveryRead.fromTrnDeliveryRead(TrnDeliveryRead source) => TrnDeliveryRead.fromJson(source.toJson());

  factory TrnDeliveryRead.fromJson(Map<String, dynamic> json) => _$TrnDeliveryReadFromJson(json);
  Map<String, dynamic> toJson() => _$TrnDeliveryReadToJson(this);

  @Uint8ListNullConverter()
  final Uint8List? updateId;
  final   String trnOrderId;
  final   String reference;
  final   TrnOrderStoreStatus storeStatus;
  final   TrnOrderDeliveryMethodStatus deliveryMethodStatus;
  final   DateTime scheduledStoreTime;
  final   DateTime scheduledDeliveryMethodTime;
  final   bool deliveryMethodAsap;
  final   String firstName;
  final   String lastName;

}
