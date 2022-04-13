import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {

  TextStyle get bold => apply(fontWeightDelta: 1);

  TextStyle get letterSpacing => apply(letterSpacingDelta: 0.2);

}
