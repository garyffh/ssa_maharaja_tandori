
import 'package:flex_color_scheme/flex_color_scheme.dart';

const flexSchemePurple = FlexSchemeData(
  name: 'Purple',
  description: 'Purple colour scheme',
  light: FlexSchemeColor(
    primary: FlexColor.materialLightPrimary,
    primaryVariant: FlexColor.materialLightPrimaryVariant,
    secondary: FlexColor.materialLightSecondary,
    secondaryVariant: FlexColor.materialLightSecondaryVariant,
    appBarColor: FlexColor.materialLightSecondaryVariant,
    error: FlexColor.materialLightError,
  ),
  dark: FlexSchemeColor(
    primary: FlexColor.materialDarkPrimary,
    primaryVariant: FlexColor.materialDarkPrimaryVariant,
    secondary: FlexColor.materialDarkSecondary,
    secondaryVariant: FlexColor.materialDarkSecondaryVariant,
    appBarColor: FlexColor.materialDarkSecondaryVariant,
    error: FlexColor.materialDarkError,
  ),
);
