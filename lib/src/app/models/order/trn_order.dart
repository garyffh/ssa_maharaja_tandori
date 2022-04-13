import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/models/infrastructure/uint8list_converter.dart';
import 'package:single_store_app/src/app/models/order/trn_order_delivery_method_status.dart';
import 'package:single_store_app/src/app/models/order/trn_order_driver.dart';
import 'package:single_store_app/src/app/models/order/trn_order_item.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';

import 'delivery_method_type.dart';

part 'trn_order.g.dart';

@JsonSerializable()
class TrnOrder {
  TrnOrder({
    required this.updateId,
    required this.trnOrderId,
    required this.orderDT,
    required this.source,
    required this.reference,
    required this.sentFfh,
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
    required this.email,
    required this.phoneNumber,
    required this.orderComment,
    required this.items,
    required this.driver,
  });

  TrnOrder.updateStatus({
    required this.storeStatus,
    required this.deliveryMethodStatus,
    required TrnOrder trnOrder,
  })  : updateId = trnOrder.updateId,
        trnOrderId = trnOrder.trnOrderId,
        orderDT = trnOrder.orderDT,
        source = trnOrder.source,
        reference = trnOrder.reference,
        sentFfh = trnOrder.sentFfh,
        currency = trnOrder.currency,
        totalEx = trnOrder.totalEx,
        taxAmount = trnOrder.taxAmount,
        total = trnOrder.total,
        paidAmount = trnOrder.paidAmount,
        deliveryCost = trnOrder.deliveryCost,
        deliveryFee = trnOrder.deliveryFee,
        orderNumber = trnOrder.orderNumber,
        pagerNumber = trnOrder.pagerNumber,
        storeTimeZone = trnOrder.storeTimeZone,
        deliveryMethodType = trnOrder.deliveryMethodType,
        scheduledStoreTime = trnOrder.scheduledStoreTime,
        scheduledDeliveryMethodTime = trnOrder.scheduledDeliveryMethodTime,
        deliveryMethodAsap = trnOrder.deliveryMethodAsap,
        company = trnOrder.company,
        companyNumber = trnOrder.companyNumber,
        addressNote = trnOrder.addressNote,
        street = trnOrder.street,
        extended = trnOrder.extended,
        locality = trnOrder.locality,
        region = trnOrder.region,
        postalCode = trnOrder.postalCode,
        country = trnOrder.country,
        lat = trnOrder.lat,
        lng = trnOrder.lng,
        timeZone = trnOrder.timeZone,
        distance = trnOrder.distance,
        firstName = trnOrder.firstName,
        lastName = trnOrder.lastName,
        email = trnOrder.email,
        phoneNumber = trnOrder.phoneNumber,
        orderComment = trnOrder.orderComment,
        items = trnOrder.items,
        driver = trnOrder.driver;

  TrnOrder.updateDriver({
    required this.deliveryMethodStatus,
    required this.driver,
    required TrnOrder trnOrder,
  })  : updateId = trnOrder.updateId,
        trnOrderId = trnOrder.trnOrderId,
        orderDT = trnOrder.orderDT,
        source = trnOrder.source,
        reference = trnOrder.reference,
        sentFfh = trnOrder.sentFfh,
        storeStatus = trnOrder.storeStatus,
        currency = trnOrder.currency,
        totalEx = trnOrder.totalEx,
        taxAmount = trnOrder.taxAmount,
        total = trnOrder.total,
        paidAmount = trnOrder.paidAmount,
        deliveryCost = trnOrder.deliveryCost,
        deliveryFee = trnOrder.deliveryFee,
        orderNumber = trnOrder.orderNumber,
        pagerNumber = trnOrder.pagerNumber,
        storeTimeZone = trnOrder.storeTimeZone,
        deliveryMethodType = trnOrder.deliveryMethodType,
        scheduledStoreTime = trnOrder.scheduledStoreTime,
        scheduledDeliveryMethodTime = trnOrder.scheduledDeliveryMethodTime,
        deliveryMethodAsap = trnOrder.deliveryMethodAsap,
        company = trnOrder.company,
        companyNumber = trnOrder.companyNumber,
        addressNote = trnOrder.addressNote,
        street = trnOrder.street,
        extended = trnOrder.extended,
        locality = trnOrder.locality,
        region = trnOrder.region,
        postalCode = trnOrder.postalCode,
        country = trnOrder.country,
        lat = trnOrder.lat,
        lng = trnOrder.lng,
        timeZone = trnOrder.timeZone,
        distance = trnOrder.distance,
        firstName = trnOrder.firstName,
        lastName = trnOrder.lastName,
        email = trnOrder.email,
        phoneNumber = trnOrder.phoneNumber,
        orderComment = trnOrder.orderComment,
        items = trnOrder.items;

  factory TrnOrder.fromJson(Map<String, dynamic> json) =>
      _$TrnOrderFromJson(json);

  Map<String, dynamic> toJson() => _$TrnOrderToJson(this);

  @Uint8ListConverter()
  final Uint8List updateId;
  final String trnOrderId;
  final DateTime orderDT;
  final String source;
  final String reference;
  final bool sentFfh;
  final TrnOrderStoreStatus storeStatus;
  final TrnOrderDeliveryMethodStatus deliveryMethodStatus;
  final String currency;
  final double totalEx;
  final double taxAmount;
  final double total;
  final double paidAmount;
  final double? deliveryCost;
  final double deliveryFee;
  final String orderNumber;
  final int? pagerNumber;
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
  final String timeZone;
  final double? distance;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String orderComment;
  final List<TrnOrderItem> items;
  final TrnOrderDriver? driver;

  List<TrnOrderItem> readableItems() =>
      items.where((element) => element.isReadable).toList();
}
