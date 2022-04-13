import 'package:flutter/material.dart';

class PeriodInterval {
  PeriodInterval({
    required this.number,
    required this.fromTime,
    required this.toTime,
    required this.orderBeforeDay,
    required this.orderBeforeTime,
  });

  final int number;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;
  final String orderBeforeDay;
  final TimeOfDay orderBeforeTime;

}
