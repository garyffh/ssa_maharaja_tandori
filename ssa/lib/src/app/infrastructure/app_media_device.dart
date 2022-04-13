import 'package:flutter/material.dart';

@immutable
class AppMediaDevice {
  const AppMediaDevice({
    required this.themeData,
    required this.orientation,
    required this.width,
    required this.height,

  });

  final ThemeData themeData;
  final Orientation orientation;
  final double width;
  final double height;

}

