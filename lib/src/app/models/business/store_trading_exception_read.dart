import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/time_of_day_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';

part 'store_trading_exception_read.g.dart';

@JsonSerializable()
class StoreTradingExceptionRead {
  StoreTradingExceptionRead({
    required this.sysStoreTradingExceptionId,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.store,
    required this.delivery,
    required this.closed,
  });

  factory StoreTradingExceptionRead.fromJson(Map<String, dynamic> json) =>
      _$StoreTradingExceptionReadFromJson(json);

  Map<String, dynamic> toJson() => _$StoreTradingExceptionReadToJson(this);

  final String sysStoreTradingExceptionId;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final bool store;
  final bool delivery;
  final bool closed;

  String get heading {
    if (startTime.day == endTime.day) {
      return '$name: ${Formats.weekDayMonthText(startTime)}';
    } else {
      return '$name: ${Formats.weekDayMonthText(startTime)} - ${Formats.weekDayMonthText(endTime)}';
    }
  }

  String get text {
    late String prefix;

    if (closed) {
      if (delivery && store) {
        prefix = 'Closed';
      } else if (delivery && !store) {
        prefix = 'Open (no deliveries)';
      } else {
        prefix = 'Closed (deliveries only)';
      }
    } else {
      if (delivery && store) {
        prefix = 'Open';
      } else if (delivery && !store) {
        prefix = 'Closed (deliveries only)';
      } else {
        prefix = 'Open (no deliveries)';
      }
    }

    final TimeOfDay startTimeOfDay = TimeOfDay.fromDateTime(startTime);
    final TimeOfDay endTimeOfDay = TimeOfDay.fromDateTime(endTime);

    if (startTime.day == endTime.day) {
      if (startTimeOfDay.isTwelveAm) {
        if (endTimeOfDay.isTwelveAm) {
          return prefix;
        } else {
          return '$prefix until ${Formats.time(endTime)}';
        }
      } else {
        if (endTimeOfDay.isTwelveAm) {
          return '$prefix from ${Formats.time(startTime)}';
        } else {
          return '$prefix ${Formats.time(startTime)} - ${Formats.time(endTime)}';
        }
      }
    } else {
      if (startTimeOfDay.isTwelveAm) {
        if (endTimeOfDay.isTwelveAm) {
          return '$prefix ${Formats.dayMonth(startTime)} - ${Formats.dayMonth(endTime)}';
        } else {
          return '$prefix ${Formats.dayMonth(startTime)} - ${Formats.dayMonthTime(endTime)}';
        }
      } else {
        if (endTimeOfDay.isTwelveAm) {
          return '$prefix ${Formats.dayMonthTime(startTime)} - ${Formats.dayMonth(endTime)}';
        } else {
          return '$prefix ${Formats.dayMonthTime(startTime)} - ${Formats.dayMonthTime(endTime)}';
        }
      }
    }
  }
}
