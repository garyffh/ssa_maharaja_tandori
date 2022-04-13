import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {

  double get toDouble => hour + (minute /60.0);

  TimeOfDay get twelveAm => const TimeOfDay(hour: 0, minute: 0);

  bool isEqualTo(TimeOfDay value) => value.toDouble == toDouble;

  bool get isTwelveAm => toDouble == twelveAm.toDouble;



}
