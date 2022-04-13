import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

import 'checkout_delivery_method_interval.dart';

@immutable
class TrnCheckoutDeliveryMethod {
  const TrnCheckoutDeliveryMethod({
    required this.storeStatusTime,
    required this.deliveryMethodType,
    required this.storeDeliveryMethodInterval,
    required this.deliveryDeliveryMethodInterval,
    required this.periodDeliveryMethodInterval,
    required this.tableNumber,
  });

  final DateTime storeStatusTime;
  final DeliveryMethodType deliveryMethodType;
  final CheckoutDeliveryMethodInterval? storeDeliveryMethodInterval;
  final CheckoutDeliveryMethodInterval? deliveryDeliveryMethodInterval;
  final CheckoutDeliveryMethodInterval? periodDeliveryMethodInterval;
  final String? tableNumber;

  CheckoutDeliveryMethodInterval? get selectedInterval {
    switch (deliveryMethodType) {
      case DeliveryMethodType.store:
        {
          return storeDeliveryMethodInterval;
        }
      case DeliveryMethodType.delivery:
        {
          return deliveryDeliveryMethodInterval;
        }
      case DeliveryMethodType.period:
        {
          return periodDeliveryMethodInterval;
        }
      case DeliveryMethodType.table:
        {
          return null;
        }
    }
  }

  String get title => deliveryMethodType.text;

  String get content => deliveryMethodType == DeliveryMethodType.table
      ? tableNumber!
      : selectedInterval!.checkoutDisplay;

  String? get checkoutTableNumber =>
      deliveryMethodType == DeliveryMethodType.table ? tableNumber! : null;

  bool get isAsap {
    if (deliveryMethodType == DeliveryMethodType.table) {
      return true;
    } else {
      if (selectedInterval != null) {
        return selectedInterval!.isAsap;
      } else {
        return false;
      }
    }
  }

  String get storeStatusTimeString {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(storeStatusTime);
  }

  String? get scheduledDeliveryMethodTimeString {
    if (isAsap) {
      return null;
    } else {
      if (selectedInterval != null) {
        if (selectedInterval!.intervalTime != null) {
          return DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(selectedInterval!.intervalTime!);
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }
}
