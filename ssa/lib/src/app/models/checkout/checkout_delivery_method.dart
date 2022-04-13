import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/models/business/delivery_method_interval.dart';
import 'package:single_store_app/src/app/models/business/store_status.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_open_status.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

import 'checkout_delivery_method_interval.dart';

part 'checkout_delivery_method.g.dart';

@JsonSerializable()
@immutable
class CheckoutDeliveryMethod {
  const CheckoutDeliveryMethod({
    required this.storeStatusTime,
    required this.storeStatus,
    required this.storeTimes,
    required this.deliveryTimes,
    required this.periodTimes,
  });

  CheckoutDeliveryMethod.fromStoreStatus(StoreStatus storeStatus)
      : storeStatusTime = storeStatus.statusTime,
        storeStatus = storeStatus.storeTimes.openStatus,
        storeTimes = checkoutStoreTimes(storeStatus: storeStatus),
        deliveryTimes = checkoutDeliveryTimes(storeStatus: storeStatus),
        periodTimes = checkoutPeriodTimes(storeStatus: storeStatus);

  factory CheckoutDeliveryMethod.fromJson(Map<String, dynamic> json) =>
      _$CheckoutDeliveryMethodFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutDeliveryMethodToJson(this);

  final DateTime storeStatusTime;
  final DeliveryMethodOpenStatus storeStatus;
  final List<CheckoutDeliveryMethodInterval> storeTimes;
  final List<CheckoutDeliveryMethodInterval> deliveryTimes;
  final List<CheckoutDeliveryMethodInterval> periodTimes;

  static List<CheckoutDeliveryMethodInterval> checkoutStoreTimes({
    required StoreStatus storeStatus,
  }) {
    if (storeStatus.storeTimes.times.isNotEmpty) {
      final List<CheckoutDeliveryMethodInterval> rtn =
          List.empty(growable: true);

      if (storeStatus.storeTimes.openStatus == DeliveryMethodOpenStatus.open) {
        rtn.add(const CheckoutDeliveryMethodInterval.fromAsap());
      }

      final DateTime storeStartTime = storeStatus.statusTime
          .add(Duration(minutes: storeStatus.storeState.storePrepTime));

      for (final DeliveryMethodInterval interval
          in storeStatus.storeTimes.times) {
        DateTime intervalTime = interval.fromTime;
        while (intervalTime.isBefore(interval.toTime)) {
          if (intervalTime.isAfter(storeStartTime)) {
            rtn.add(CheckoutDeliveryMethodInterval.fromInterval(
                intervalTime: intervalTime));
          }
          intervalTime = intervalTime
              .add(Duration(minutes: AppConstants.deliveryMethodInterval));
        }
      }

      return rtn;
    } else {
      return List.empty();
    }
  }

  static List<CheckoutDeliveryMethodInterval> checkoutDeliveryTimes({
    required StoreStatus storeStatus,
  }) {
    if (storeStatus.deliveryTimes.times.isNotEmpty) {
      final List<CheckoutDeliveryMethodInterval> rtn =
          List.empty(growable: true);

      if (storeStatus.deliveryTimes.openStatus ==
          DeliveryMethodOpenStatus.open) {
        rtn.add(const CheckoutDeliveryMethodInterval.fromAsap());
      }

      final DateTime deliveryStartTime = storeStatus.statusTime.add(Duration(
          minutes: storeStatus.storeState.storePrepTime +
              storeStatus.storeState.driverDeliveryTime));

      for (final DeliveryMethodInterval interval
          in storeStatus.deliveryTimes.times) {
        DateTime intervalTime = interval.fromTime;
        while (intervalTime.isBefore(interval.toTime)) {
          if (intervalTime.isAfter(deliveryStartTime)) {
            rtn.add(CheckoutDeliveryMethodInterval.fromInterval(
                intervalTime: intervalTime));
          }
          intervalTime = intervalTime
              .add(Duration(minutes: AppConstants.deliveryMethodInterval));
        }
      }

      return rtn;
    } else {
      return List.empty();
    }
  }

  static List<CheckoutDeliveryMethodInterval> checkoutPeriodTimes({
    required StoreStatus storeStatus,
  }) {
    if (storeStatus.periodTimes.times.isNotEmpty) {
      return List.generate(
        storeStatus.periodTimes.times.length,
        (index) => CheckoutDeliveryMethodInterval.fromPeriod(
            intervalTime: storeStatus.periodTimes.times[index].fromTime,
            toTime: storeStatus.periodTimes.times[index].toTime),
      );
    } else {
      return List.empty();
    }
  }

  bool get isClosed => !(storeTimes.isNotEmpty ||
      deliveryTimes.isNotEmpty ||
      periodTimes.isNotEmpty);

  List<DeliveryMethodType> activeDeliveryMethods(bool includeTableService) {
    final List<DeliveryMethodType> rtn = List.empty(growable: true);
    if (storeTimes.isNotEmpty) {
      rtn.add(DeliveryMethodType.store);
    }
    if (deliveryTimes.isNotEmpty) {
      rtn.add(DeliveryMethodType.delivery);
    }
    if (periodTimes.isNotEmpty) {
      rtn.add(DeliveryMethodType.period);
    }
    if (includeTableService && storeTimes.isNotEmpty) {
      rtn.add(DeliveryMethodType.table);
    }
    return rtn;
  }
}
