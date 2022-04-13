import 'package:flutter/material.dart';

abstract class AppThemeEvent {}

class AppThemeEventThemeFromStorage extends AppThemeEvent {
  AppThemeEventThemeFromStorage();


}

class AppThemeEventThemeUpdateFromServer extends AppThemeEvent {
  AppThemeEventThemeUpdateFromServer({
    required this.businessName,
    required this.theme,
  });

  final String businessName;
  final String theme;

}

class AppThemeEventModeUpdate extends AppThemeEvent {
  AppThemeEventModeUpdate({
    required this.themeMode,
  });

  final ThemeMode themeMode;

}
