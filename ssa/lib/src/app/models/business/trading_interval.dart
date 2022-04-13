import 'package:flutter/material.dart';

class TradingInterval {
  TradingInterval({
    required this.number,
    required this.fromTime,
    required this.toTime,
  });

  final int number;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;

}
