// build schemes from a
// single primary color. With the [.from] factory, then the only required color
// is the primary color, the other colors will be computed. You can optionally
// also provide the primaryVariant, secondary and secondaryVariant colors with
// the factory, but any color that is not provided will always be computed for
// the full set of required colors in a FlexSchemeColor.

// In this example we create our 2nd scheme from just a primary color
// for the light and dark schemes. The custom app bar color will in this case
// also receive the same color value as the one that is computed for
// secondaryVariant color, this is the default with the [from] factory.
import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';

FlexSchemeData flexScheme2 = FlexSchemeData(
  name: 'FlexScheme 2',
  description: 'Olive green theme, created from primary light and dark colors.',
  light: FlexSchemeColor.from(primary: const Color(0xFF4C4E06)),
  dark: FlexSchemeColor.from(primary: const Color(0xFF9D9E76)),
);

