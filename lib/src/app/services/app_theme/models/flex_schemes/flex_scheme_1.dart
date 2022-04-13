// Create a custom flex scheme color for a light theme.
import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';

// You can build a scheme the long way, by specifying all the required hand
// picked scheme colors,

const flexScheme1 = FlexSchemeData(
  name: 'FlexScheme 1',
  description: 'Purple theme, created from full custom defined color scheme.',
  light: FlexSchemeColor(
    primary: Color(0xFF4E0028),
    primaryVariant: Color(0xFF320019),
    secondary: Color(0xFF003419),
    secondaryVariant: Color(0xFF002411),
    appBarColor: Color(0xFF002411),
  ),
  dark: FlexSchemeColor(
    primary: Color(0xFF9E7389),
    primaryVariant: Color(0xFF775C69),
    secondary: Color(0xFF738F81),
    secondaryVariant: Color(0xFF5C7267),
    appBarColor: Color(0xFF5C7267),
  ),
);

