import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';

// define primary and secondary colors, but no
// variant colors, we will not make any dark scheme definitions either.

final FlexSchemeColor flexScheme3Light = FlexSchemeColor.from(
  primary: const Color(0xFF993200),
  secondary: const Color(0xFF1B5C62),
);

FlexSchemeData flexScheme3 = FlexSchemeData(
  name: 'FlexScheme 3',
  description: 'Custom orange and blue theme, from only light scheme colors.',
  light: FlexSchemeColor.from(
    primary: const Color(0xFF993200),
    secondary: const Color(0xFF1B5C62),
  ),
  dark: FlexSchemeColor.from(
    primary: const Color(0xFF993200),
    secondary: const Color(0xFF1B5C62),
  ).toDark(),
);
