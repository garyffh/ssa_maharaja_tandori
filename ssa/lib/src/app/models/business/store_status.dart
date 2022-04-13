import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/models/business/store_state.dart';
import 'package:single_store_app/src/app/models/business/store_status_display.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_open_status.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

import 'delivery_method_times.dart';
import 'open_status.dart';

part 'store_status.g.dart';

@CopyWith()
@JsonSerializable()
class StoreStatus {
  StoreStatus({
    required this.statusTime,
    required this.storeState,
    required this.storeTimes,
    required this.deliveryTimes,
    required this.periodTimes,
    required this.openStatus,
  });

  factory StoreStatus.fromJson(Map<String, dynamic> json) =>
      _$StoreStatusFromJson(json);

  Map<String, dynamic> toJson() => _$StoreStatusToJson(this);

  final DateTime statusTime;
  final StoreState storeState;
  final DeliveryMethodTimes storeTimes;
  final DeliveryMethodTimes deliveryTimes;
  final DeliveryMethodTimes periodTimes;
  final OpenStatus openStatus;

  StoreStatusDisplay storeTimesDisplay({
    required bool useDeliveryZones,
    required double deliveryFee,
    required double minOrder,
  }) {
    return deliveryMethodTimesHeaderText(
        useDeliveryZones: useDeliveryZones,
        deliveryFee: deliveryFee,
        minOrder: minOrder,
        deliveryMethodTimes: storeTimes);
  }

  StoreStatusDisplay deliveryTimesDisplay({
    required bool useDeliveryZones,
    required double deliveryFee,
    required double minOrder,
    required bool useDeliveryPeriods,
  }) {
    if (useDeliveryPeriods) {
      return deliveryMethodTimesHeaderText(
          useDeliveryZones: useDeliveryZones,
          deliveryFee: deliveryFee,
          minOrder: minOrder,
          deliveryMethodTimes: periodTimes);
    } else {
      return deliveryMethodTimesHeaderText(
          useDeliveryZones: useDeliveryZones,
          deliveryFee: deliveryFee,
          minOrder: minOrder,
          deliveryMethodTimes: deliveryTimes);
    }
  }

  StoreStatusDisplay deliveryMethodTimesHeaderText({
    required bool useDeliveryZones,
    required double deliveryFee,
    required double minOrder,
    required DeliveryMethodTimes deliveryMethodTimes,
  }) {
    switch (deliveryMethodTimes.type) {
      case DeliveryMethodType.store:
        {
          if (storeState.manualStoreOnline) {
            switch (deliveryMethodTimes.openStatus) {
              case DeliveryMethodOpenStatus.schedule:
                {
                  return StoreStatusDisplay(
                    title: 'ORDER AHEAD',
                    bodyLine1:
                        'Order ahead ${deliveryMethodTimes.displayTimes}',
                    bodyLine2: 'Schedule your order for pickup later.',
                  );
                }
              case DeliveryMethodOpenStatus.closed:
                {
                  return StoreStatusDisplay(
                    title: 'ORDER AHEAD CLOSED',
                    bodyLine1: 'Order ahead is closed. Check our store hours.',
                  );
                }

              case DeliveryMethodOpenStatus.open:
                {
                  return StoreStatusDisplay(
                    title: 'ORDER AHEAD',
                    bodyLine1:
                        'Order ahead ${deliveryMethodTimes.displayTimes}',
                    bodyLine2:
                        'Pickup your order in around ${Formats.minutes(storeState.storePrepTime)} minutes or schedule it for pickup later.',
                  );
                }
            }
          } else {
            // no store
            return StoreStatusDisplay(
              title: 'OFFLINE',
              bodyLine1:
                  'Pickup your order in around minutes or schedule it for pickup later.',
            );
          }
        }

      case DeliveryMethodType.delivery:
        {
          if (storeState.driverAvailable && storeState.manualDeliveryOnline) {
            switch (deliveryMethodTimes.openStatus) {
              case DeliveryMethodOpenStatus.schedule:
                {
                  if (minOrder == 0) {
                    return StoreStatusDisplay(
                      title: useDeliveryZones
                          ? 'DELIVERY'
                          : deliveryFee == 0
                              ? 'FREE DELIVERY'
                              : 'DELIVERY ( ${Formats.currency(deliveryFee)}',
                      bodyLine1:
                          'Deliveries  ${deliveryMethodTimes.displayTimes}',
                      bodyLine2:
                          'Schedule your order for delivery later. Check you are in our delivery area.',
                    );
                  } else {
                    return StoreStatusDisplay(
                      title: useDeliveryZones
                          ? 'DELIVERY'
                          : deliveryFee == 0
                              ? 'FREE DELIVERY'
                              : 'DELIVERY ( ${Formats.currency(deliveryFee)}',
                      bodyLine1: 'Minimum order ${Formats.currency(minOrder)}',
                      bodyLine2:
                          'Deliveries  ${deliveryMethodTimes.displayTimes}',
                      bodyLine3:
                          'Schedule your order for delivery later. Check you are in our delivery area.',
                    );
                  }
                }
              case DeliveryMethodOpenStatus.closed:
                {
                  return StoreStatusDisplay(
                    title: 'DELIVERY CLOSED',
                    bodyLine1:
                        'Deliveries are closed. Check our delivery hours',
                  );
                }

              case DeliveryMethodOpenStatus.open:
                {
                  if (minOrder == 0) {
                    return StoreStatusDisplay(
                      title: useDeliveryZones
                          ? 'DELIVERY'
                          : deliveryFee == 0
                              ? 'FREE DELIVERY'
                              : 'DELIVERY ( ${Formats.currency(deliveryFee)}',
                      bodyLine1:
                          'Deliveries  ${deliveryMethodTimes.displayTimes}',
                      bodyLine2:
                          'Have your order delivered in around ${Formats.minutes(storeState.storePrepTime + storeState.driverDeliveryTime)} minutes, or schedule it for delivery later. Check you are in our delivery area.',
                    );
                  } else {
                    return StoreStatusDisplay(
                      title: useDeliveryZones
                          ? 'DELIVERY'
                          : deliveryFee == 0
                              ? 'FREE DELIVERY'
                              : 'DELIVERY ( ${Formats.currency(deliveryFee)}',
                      bodyLine1: 'Minimum order ${Formats.currency(minOrder)}',
                      bodyLine2:
                          'Deliveries  ${deliveryMethodTimes.displayTimes}',
                      bodyLine3:
                          'Have your order delivered in around ${Formats.minutes(storeState.storePrepTime + storeState.driverDeliveryTime)} minutes, or schedule it for delivery later. Check you are in our delivery area.',
                    );
                  }
                }
            }
          } else {
            // no deliveries
            if(!storeState.driverAvailable) {
              return StoreStatusDisplay(
                title: 'DELIVERY OFFLINE',
                bodyLine1: AppConstants.driverNotAvailableMessage,
              );
            } else {
              return StoreStatusDisplay(
                title: 'DELIVERY OFFLINE',
                bodyLine1: AppConstants.deliveryOfflineMessage,
              );
            }
          }
        }
      case DeliveryMethodType.table:
        {
          if (storeState.manualStoreOnline) {
            switch (deliveryMethodTimes.openStatus) {
              case DeliveryMethodOpenStatus.schedule:
                {
                  return StoreStatusDisplay(
                    title: 'ORDER AHEAD',
                    bodyLine1:
                        'Order ahead ${deliveryMethodTimes.displayTimes}',
                    bodyLine2: 'Schedule your order for pickup later.',
                  );
                }
              case DeliveryMethodOpenStatus.closed:
                {
                  return StoreStatusDisplay(
                    title: 'ORDER AHEAD CLOSED',
                    bodyLine1: 'Order ahead is closed. Check our store hours.',
                  );
                }

              case DeliveryMethodOpenStatus.open:
                {
                  return StoreStatusDisplay(
                    title: 'ORDER AHEAD',
                    bodyLine1:
                        'Order ahead ${deliveryMethodTimes.displayTimes}',
                    bodyLine2:
                        'Pickup your order in around ${Formats.minutes(storeState.storePrepTime)} minutes or schedule it for pickup later.',
                  );
                }
            }
          } else {
            // no store
            return StoreStatusDisplay(
              title: 'OFFLINE',
              bodyLine1:
                  'Pickup your order in around minutes or schedule it for pickup later.',
            );
          }
        }
      case DeliveryMethodType.period:
        {
          if (deliveryMethodTimes.times.isNotEmpty) {
            switch (deliveryMethodTimes.openStatus) {
              case DeliveryMethodOpenStatus.schedule:
                {
                  if (minOrder == 0) {
                    return StoreStatusDisplay(
                      title: useDeliveryZones
                          ? 'DELIVERY'
                          : deliveryFee == 0
                              ? 'FREE DELIVERY'
                              : 'DELIVERY ${Formats.currency(deliveryFee)}',
                      bodyLine1:
                          'Schedule your order for delivery. Check our delivery times.',
                    );
                  } else {
                    return StoreStatusDisplay(
                      title: useDeliveryZones
                          ? 'DELIVERY'
                          : deliveryFee == 0
                              ? 'FREE DELIVERY'
                              : 'DELIVERY ${Formats.currency(deliveryFee)}',
                      bodyLine1: 'Minimum order ${Formats.currency(minOrder)}',
                      bodyLine2:
                          'Schedule your order for delivery. Check our delivery times.',
                    );
                  }
                }
              case DeliveryMethodOpenStatus.closed:
                {
                  return StoreStatusDisplay(
                    title: 'DELIVERY CLOSED',
                    bodyLine1:
                        'Deliveries are closed. Check our delivery times',
                  );
                }

              case DeliveryMethodOpenStatus.open:
                {
                  if (minOrder == 0) {
                    return StoreStatusDisplay(
                      title: useDeliveryZones
                          ? 'DELIVERY'
                          : deliveryFee == 0
                              ? 'FREE DELIVERY'
                              : 'DELIVERY ${Formats.currency(deliveryFee)}',
                      bodyLine1:
                          'Schedule your order for delivery. Check our delivery times.',
                    );
                  } else {
                    return StoreStatusDisplay(
                      title: useDeliveryZones
                          ? 'DELIVERY'
                          : deliveryFee == 0
                              ? 'FREE DELIVERY'
                              : 'DELIVERY ${Formats.currency(deliveryFee)}',
                      bodyLine1: 'Minimum order ${Formats.currency(minOrder)}',
                      bodyLine2:
                          'Schedule your order for delivery. Check our delivery times.',
                    );
                  }
                }
            }
          } else {
            // no deliveries
            if (storeState.driverAvailable) {
              return StoreStatusDisplay(
                title: 'DELIVERY OFFLINE',
                bodyLine1: AppConstants.deliveryOfflineMessage,
              );
            } else {
              return StoreStatusDisplay(
                title: 'DELIVERY OFFLINE',
                bodyLine1: AppConstants.driverNotAvailableMessage,
              );
            }
          }
        }
    }
  }
}
