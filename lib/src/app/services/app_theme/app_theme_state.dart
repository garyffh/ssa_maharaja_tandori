import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/constants/app_theme.constants.dart';

import 'app_flex_scheme_theme.dart';

@immutable
abstract class AppThemeState {
  const AppThemeState({
    required this.businessName,
    required this.theme,
    required this.themeMode,
  });

  final String businessName;
  final String theme;
  final ThemeMode themeMode;

  FlexSchemeData get flexSchemeData => AppSchemeTheme.flexSchemeFromTheme(theme);

  ThemeData get lightThemeData => FlexColorScheme.light(
        colors: flexSchemeData.light,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: AppConstants.mainFont,
      ).toTheme;

  ThemeData get darkThemeData => FlexColorScheme.dark(
        colors: flexSchemeData.dark,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: AppConstants.mainFont,
      ).toTheme;

  AppBar? appAppBar();

}

class AppThemeStateInitial extends AppThemeState {
  const AppThemeStateInitial()
      : super(
          businessName: '',
          theme: AppThemeConstants.defaultTheme,
          themeMode: ThemeMode.system,
        );

  @override
  AppBar? appAppBar() {
    return null;
  }
}

class AppThemeStateLoaded extends AppThemeState {
  const AppThemeStateLoaded(
      {required String businessName,
      required String theme,
      required ThemeMode themeMode})
      : super(
          businessName: businessName,
          theme: theme,
          themeMode: themeMode,
        );

  @override
  AppBar? appAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        businessName),
    );
  }
}
