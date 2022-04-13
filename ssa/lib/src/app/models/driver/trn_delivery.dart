import 'dart:core';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/driver/trn_deliveries_item.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';

part 'trn_delivery.g.dart';

@JsonSerializable()
class TrnDelivery {
  TrnDelivery({
    required this.updateId,
    required this.trnOrderId,
    required this.reference,
    required this.storeStatus,
    required this.deliveryMethodStatus,
    required this.currency,
    required this.totalEx,
    required this.taxAmount,
    required this.total,
    required this.paidAmount,
    required this.deliveryCost,
    required this.deliveryFee,
    required this.orderNumber,
    required this.pagerNumber,
    required this.storeTimeZone,
    required this.deliveryMethodType,
    required this.scheduledStoreTime,
    required this.scheduledDeliveryMethodTime,
    required this.deliveryMethodAsap,
    required this.company,
    required this.companyNumber,
    required this.addressNote,
    required this.street,
    required this.extended,
    required this.locality,
    required this.region,
    required this.postalCode,
    required this.country,
    required this.lat,
    required this.lng,
    required this.timeZone,
    required this.distance,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.orderComment,
    required this.items,
  });

  TrnDelivery.updateStatus({
    required this.storeStatus,
    required this.deliveryMethodStatus,
    required TrnDelivery trnDelivery,
  })  : updateId = trnDelivery.updateId,
        trnOrderId = trnDelivery.trnOrderId,
        reference = trnDelivery.reference,
        currency = trnDelivery.currency,
        totalEx = trnDelivery.totalEx,
        taxAmount = trnDelivery.taxAmount,
        total = trnDelivery.total,
        paidAmount = trnDelivery.paidAmount,
        deliveryCost = trnDelivery.deliveryCost,
        deliveryFee = trnDelivery.deliveryFee,
        orderNumber = trnDelivery.orderNumber,
        pagerNumber = trnDelivery.pagerNumber,
        storeTimeZone = trnDelivery.storeTimeZone,
        deliveryMethodType = trnDelivery.deliveryMethodType,
        scheduledStoreTime = trnDelivery.scheduledStoreTime,
        scheduledDeliveryMethodTime = trnDelivery.scheduledDeliveryMethodTime,
        deliveryMethodAsap = trnDelivery.deliveryMethodAsap,
        company = trnDelivery.company,
        companyNumber = trnDelivery.companyNumber,
        addressNote = trnDelivery.addressNote,
        street = trnDelivery.street,
        extended = trnDelivery.extended,
        locality = trnDelivery.locality,
        region = trnDelivery.region,
        postalCode = trnDelivery.postalCode,
        country = trnDelivery.country,
        lat = trnDelivery.lat,
        lng = trnDelivery.lng,
        timeZone = trnDelivery.timeZone,
        distance = trnDelivery.distance,
        firstName = trnDelivery.firstName,
        lastName = trnDelivery.lastName,
        phoneNumber = trnDelivery.phoneNumber,
        orderComment = trnDelivery.orderComment,
        items = trnDelivery.items;

  factory TrnDelivery.fromTrnDelivery(TrnDelivery source) =>
      TrnDelivery.fromJson(source.toJson());

  factory TrnDelivery.fromJson(Map<String, dynamic> json) =>
      _$TrnDeliveryFromJson(json);

  Map<String, dynamic> toJson() => _$TrnDeliveryToJson(this);

  @Uint8ListConverter()
  final Uint8List updateId;
  final String trnOrderId;
  final String reference;
  final TrnOrderStoreStatus storeStatus;
  final TrnOrderDeliveryMethodStatus deliveryMethodStatus;
  final String currency;
  final double totalEx;
  final double taxAmount;
  final double total;
  final double paidAmount;
  final double deliveryCost;
  final double deliveryFee;
  final String orderNumber;
  final int pagerNumber;
  final String storeTimeZone;
  final DeliveryMethodType deliveryMethodType;
  final DateTime scheduledStoreTime;
  final DateTime scheduledDeliveryMethodTime;
  final bool deliveryMethodAsap;
  final String company;
  final String companyNumber;
  final String addressNote;
  final String street;
  final String extended;
  final String locality;
  final String region;
  final String postalCode;
  final String country;
  final double? lat;
  final double? lng;
  final String? timeZone;
  final double? distance;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String orderComment;
  final List<TrnDeliveriesItem> items;

  List<TrnDeliveriesItem> readableItems() =>
      items.where((element) => element.isReadable).toList();
}
