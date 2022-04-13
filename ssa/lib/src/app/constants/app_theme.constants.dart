import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/infrastructure/app_media_device.dart';

import 'app.constants.dart';

class AppThemeConstants {
  const AppThemeConstants._();

  static AppMediaDevice get defaultAppMediaDevice => AppMediaDevice(
        themeData: defaultThemeData,
        height: _minHeight,
        width: _minWidth,
        orientation: Orientation.portrait,
      );

  static ThemeData get defaultThemeData => FlexColorScheme.light(
        colors: _defaultFlexSchemeData.light,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: AppConstants.mainFont,
      ).toTheme;

  static const FlexSchemeData _defaultFlexSchemeData = FlexSchemeData(
    name: FlexColor.ebonyClayName,
    description: FlexColor.ebonyClayDescription,
    light: FlexSchemeColor(
      primary: FlexColor.ebonyClayLightPrimary,
      primaryVariant: FlexColor.ebonyClayLightPrimaryVariant,
      secondary: FlexColor.ebonyClayLightSecondary,
      secondaryVariant: FlexColor.ebonyClayLightSecondaryVariant,
      appBarColor: FlexColor.ebonyClayLightSecondaryVariant,
      error: FlexColor.materialLightError,
    ),
    dark: FlexSchemeColor(
      primary: FlexColor.ebonyClayDarkPrimary,
      primaryVariant: FlexColor.ebonyClayDarkPrimaryVariant,
      secondary: FlexColor.ebonyClayDarkSecondary,
      secondaryVariant: FlexColor.ebonyClayDarkSecondaryVariant,
      appBarColor: FlexColor.ebonyClayDarkSecondaryVariant,
      error: FlexColor.materialDarkError,
    ),
  );

  static const String defaultTheme = 'ebony';
  static const double _minHeight = 569;
  static const double _minWidth = 320;
}
