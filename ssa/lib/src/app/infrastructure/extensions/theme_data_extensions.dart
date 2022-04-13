import 'package:flutter/material.dart';

extension ThemeDataExtensions on ThemeData {

  Color get primaryTextColor => colorScheme.onPrimary;

  Color get primaryDarkTextColor => ThemeData.estimateBrightnessForColor(primaryColorDark) ==
      Brightness.dark
      ? Colors.white
      : Colors.black;

  Color get primaryLightTextColor => ThemeData.estimateBrightnessForColor(primaryColorLight) ==
      Brightness.dark
      ? Colors.white
      : Colors.black;

  Color get secondaryHeaderTextColor => ThemeData.estimateBrightnessForColor(secondaryHeaderColor) ==
      Brightness.dark
      ? Colors.white
      : Colors.black;

  Color get primaryContainerColor => colorScheme.primaryContainer;

  Color get primaryContainerTextColor => ThemeData.estimateBrightnessForColor(colorScheme.primaryContainer) ==
      Brightness.dark
      ? Colors.white
      : Colors.black;

  Color get secondaryColor => colorScheme.secondary;

  Color get secondaryTextColor => colorScheme.onSecondary;

  Color get toggleableActiveTextColor => ThemeData.estimateBrightnessForColor(toggleableActiveColor) ==
      Brightness.dark
      ? Colors.white
      : Colors.black;

  Color get secondaryContainerColor => colorScheme.secondaryContainer;

  Color get secondaryContainerTextColor => ThemeData.estimateBrightnessForColor(colorScheme.secondaryContainer) ==
      Brightness.dark
      ? Colors.white
      : Colors.black;

  Color get appBarColor => appBarTheme.backgroundColor ?? primaryColor;

  Color get appBarTextColor => ThemeData.estimateBrightnessForColor(appBarColor) ==
      Brightness.dark
      ? Colors.white
      : Colors.black;

  Color get bottomAppBarTextColor => ThemeData.estimateBrightnessForColor(bottomAppBarColor) ==
      Brightness.dark
      ? Colors.white
      : Colors.black;

  Color get titleBackgroundColor => colorScheme.background;

  Color get titleColor => colorScheme.onBackground;

  Color get dividerTextColor => colorScheme.onBackground;

  Color get backgroundColor => colorScheme.background;

  Color get backgroundTextColor => colorScheme.onBackground;

  Color get canvasTextColor => colorScheme.onBackground;

  Color get surfaceColor => colorScheme.surface;

  Color get surfaceTextColor => colorScheme.onSurface;

  Color get cardTextColor => colorScheme.onBackground;

  Color get dialogTextColor => colorScheme.onBackground;

  Color get scaffoldTextColor => colorScheme.onBackground;

  Color get errorTextColor => colorScheme.onError;

  Color get bottomNavigationUnselectedColor => textTheme.caption!.color!;

  TextStyle get bottomNavigationUnselectedStyle => textTheme.caption!;

  IconThemeData get bottomNavigationUnselectedIconTheme => iconTheme.copyWith(color: disabledColor);


}
