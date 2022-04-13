import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';

part 'checkout_delivery_method_interval.g.dart';

@JsonSerializable()
@immutable
class CheckoutDeliveryMethodInterval extends Equatable {
  const CheckoutDeliveryMethodInterval({
    this.intervalTime,
    this.toTime,
    this.isAsap = false,
  });

  const CheckoutDeliveryMethodInterval.fromAsap()
      : intervalTime = null,
        toTime = null,
        isAsap = true;

  const CheckoutDeliveryMethodInterval.fromInterval(
      {required this.intervalTime})
      : toTime = null,
        isAsap = false;

  const CheckoutDeliveryMethodInterval.fromPeriod(
      {required this.intervalTime, required this.toTime})
      : isAsap = false;

  factory CheckoutDeliveryMethodInterval.fromJson(Map<String, dynamic> json) =>
      _$CheckoutDeliveryMethodIntervalFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutDeliveryMethodIntervalToJson(this);

  final DateTime? intervalTime;
  final DateTime? toTime;
  final bool isAsap;

  @override
  List<Object?> get props => [intervalTime, toTime, isAsap];

  String get display {
    if (isAsap) {
      return 'ASAP';
    } else if (intervalTime != null && toTime != null) {
      return '${Formats.weekDayTime(intervalTime!)} - ${Formats.time(toTime!)}';
    } else if (intervalTime != null) {
      return Formats.time(intervalTime!);
    } else {
      return 'UNKNOWN';
    }
  }


  String get checkoutDisplay {
    if (isAsap) {
      return 'ASAP';
    } else if (intervalTime != null && toTime != null) {
      return '${Formats.weekDayMonthTime(intervalTime!)} - ${Formats.time(toTime!)}';
    } else if (intervalTime != null) {
      return 'About ${Formats.time(intervalTime!)}';
    } else {
      return 'UNKNOWN';
    }
  }
}
