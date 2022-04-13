import 'package:flutter/material.dart';

extension StringExtensions on String {

  TimeOfDay toTimeOfDay() => TimeOfDay(hour: int.parse(split(':')[0]), minute: int.parse(split(':')[1]));

}

extension StringNullExtensions on String? {

  bool get isNullOrEmpty => this?.trim().isEmpty ?? true;

}
