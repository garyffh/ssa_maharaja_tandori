import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_open_status.dart';
import 'package:single_store_app/src/app/models/order/delivery_method_type.dart';

import 'delivery_method_interval.dart';

part 'delivery_method_times.g.dart';

@JsonSerializable()
class DeliveryMethodTimes {
  DeliveryMethodTimes({
    required this.type,
    required this.times,
    required this.openStatus,
  });

  factory DeliveryMethodTimes.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodTimesFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryMethodTimesToJson(this);

  final DeliveryMethodType type;
  final List<DeliveryMethodInterval> times;
  final DeliveryMethodOpenStatus openStatus;

  String get displayTimes {
    switch (openStatus) {
      case DeliveryMethodOpenStatus.schedule:
        {
          if (times.isEmpty) {
            return 'closed';
          } else if (times.length == 1) {
            return 'from ${Formats.time(times[0].fromTime)} - ${Formats.time(times[0].toTime)}';
          } else {
            return 'from ${Formats.time(times[0].fromTime)} - ${Formats.time(times[0].toTime)} and ${Formats.time(times[1].fromTime)} - ${Formats.time(times[1].toTime)}';
          }
        }

      case DeliveryMethodOpenStatus.open:
        {
          if (times.isEmpty) {
            return 'closed';
          } else if (times.length == 1) {
            return 'until ${Formats.time(times[0].fromTime)} - ${Formats.time(times[0].toTime)}';
          } else {
            return 'until ${Formats.time(times[0].fromTime)} - ${Formats.time(times[0].toTime)} and ${Formats.time(times[1].fromTime)} - ${Formats.time(times[1].toTime)}';
          }
        }

      case DeliveryMethodOpenStatus.closed:
        {
          return 'closed';
        }
    }
  }
}
