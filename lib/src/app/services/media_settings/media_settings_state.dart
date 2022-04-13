import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/constants/app_theme.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_media_device.dart';
import 'package:single_store_app/src/app/infrastructure/app_media_screen_size.dart';

@immutable
abstract class MediaSettingsState {
  const MediaSettingsState({
    required this.appMediaDevice,
  });

  static const double xsWidth = 321.0; /// xs < 320
  static const double smWidth = 361.0; /// sm < 360
  static const double mdWidth = 413.0; /// md < 412
  static const double lgWidth = 601.0; /// lg < 600 xl >= 600 ie Tablet

  final AppMediaDevice appMediaDevice;

  double get xsWidthSize => xsWidth;
  double get smWidthSize => smWidth;
  double get mdWidthSize => mdWidth;
  double get lgWidthSize => lgWidth;

  bool get isMobile {
    if (appMediaDevice.orientation == Orientation.portrait) {
      return appMediaDevice.width < lgWidth;
    } else {
      return appMediaDevice.height < lgWidth;
    }
  }

  AppMediaScreenSize get deviceScreenWidth {

    if ((appMediaDevice.orientation == Orientation.portrait &&
            appMediaDevice.width < xsWidth) ||
        (appMediaDevice.orientation == Orientation.landscape &&
            appMediaDevice.height < xsWidth)) {
      return AppMediaScreenSize.xs;
    } else if ((appMediaDevice.orientation == Orientation.portrait &&
            appMediaDevice.width < smWidth) ||
        (appMediaDevice.orientation == Orientation.landscape &&
            appMediaDevice.height < smWidth)) {
      return AppMediaScreenSize.sm;
    } else if ((appMediaDevice.orientation == Orientation.portrait &&
            appMediaDevice.width < mdWidth) ||
        (appMediaDevice.orientation == Orientation.landscape &&
            appMediaDevice.height < mdWidth)) {
      return AppMediaScreenSize.md;
    } else if ((appMediaDevice.orientation == Orientation.portrait &&
            appMediaDevice.width < lgWidth) ||
        (appMediaDevice.orientation == Orientation.landscape &&
            appMediaDevice.height < lgWidth)) {
      return AppMediaScreenSize.lg;
    } else {
      return AppMediaScreenSize.xl;
    }
  }

  AppMediaScreenSize get screenWidth {

    if (appMediaDevice.width < xsWidth) {
      return AppMediaScreenSize.xs;
    } else if (appMediaDevice.width < smWidth) {
      return AppMediaScreenSize.sm;
    } else if (appMediaDevice.width < mdWidth) {
      return AppMediaScreenSize.md;
    } else if (appMediaDevice.width < lgWidth) {
      return AppMediaScreenSize.lg;
    } else {
      return AppMediaScreenSize.xl;
    }
  }

  bool get gtXs => appMediaDevice.width > xsWidth;

  bool get gtSm => appMediaDevice.width > smWidth;

  bool get gtMd => appMediaDevice.width > mdWidth;

  bool get gtLg => appMediaDevice.width > lgWidth;


  static double get aspectRatio {
    return WidgetsBinding.instance?.window.physicalSize.aspectRatio ?? 1;
  }

  static double get pixelRatio {
    return WidgetsBinding.instance?.window.devicePixelRatio ?? 1;
  }

  bool get isMobilePlatform =>
      appMediaDevice.themeData.platform == TargetPlatform.iOS ||
      appMediaDevice.themeData.platform == TargetPlatform.android;

  Orientation get orientation => appMediaDevice.orientation;

  double get height => appMediaDevice.height;

  double get width => appMediaDevice.width;

  double h(double value) => value * appMediaDevice.height / 100;

  double w(double value) => value * appMediaDevice.width / 100;

  /// sp (Scalable Pixel) from pixel density
  double sp(double value) =>
      value *
      (((h(value) + w(value)) + (pixelRatio * aspectRatio)) / 2.08) /
      100;

  double get sp4 => sp(4);

  double get sp8 => sp(8);

  double get sp10 => sp(10);

  double get sp12 => sp(12);

  double get sp14 => sp(14);

  double get sp16 => sp(16);

  double get sp18 => sp(18);

  double get sp20 => sp(20);

  double get sp22 => sp(22);

  double get sp24 => sp(24);

  double get sp26 => sp(26);

  double get sp28 => sp(28);

  double get sp30 => sp(30);

  double get sp32 => sp(32);

  double get sp34 => sp(34);

  double get sp56 => sp(56);

  double get sp64 => sp(64);

  // double get padding => sp(16);

  double get subTitleTextMaxWidth => sp(60);

  double get smallPadding => sp(8);

  double get formMaxWidth => sp(90);

  double get formPadding => sp(16);

  // double get formFieldPadding => sp(16);

  // double get formFieldTextSize => sp(18);

  double get formFieldIconSize => sp(18);

  // double get formFieldHelpTextSize => sp(16);

  // double get formFieldErrorTextSize => sp(16);

  double get buttonFontSize => sp(20);

  double get buttonIconSize => sp(22);

  double get buttonIconSpacing => sp(10);

  TextStyle get headline1 =>
      appMediaDevice.themeData.textTheme.headline1!.copyWith(fontSize: sp(96));

  TextStyle get headline2 =>
      appMediaDevice.themeData.textTheme.headline2!.copyWith(fontSize: sp(60));

  TextStyle get headline3 =>
      appMediaDevice.themeData.textTheme.headline3!.copyWith(fontSize: sp(48));

  TextStyle get headline4 =>
      appMediaDevice.themeData.textTheme.headline4!.copyWith(fontSize: sp(34));

  TextStyle get headline5 =>
      appMediaDevice.themeData.textTheme.headline5!.copyWith(fontSize: sp(24));

  TextStyle get headline6 =>
      appMediaDevice.themeData.textTheme.headline6!.copyWith(fontSize: sp(19));

  TextStyle get subtitle1 =>
      appMediaDevice.themeData.textTheme.subtitle1!.copyWith(fontSize: sp(18));

  TextStyle get subtitle2 =>
      appMediaDevice.themeData.textTheme.subtitle2!.copyWith(fontSize: sp(16));

  TextStyle get bodyText1 =>
      appMediaDevice.themeData.textTheme.bodyText1!.copyWith(fontSize: sp(16));

  TextStyle get bodyText2 =>
      appMediaDevice.themeData.textTheme.bodyText2!.copyWith(fontSize: sp(14));

  TextStyle get button =>
      appMediaDevice.themeData.textTheme.button!.copyWith(fontSize: sp(14));

  TextStyle get caption =>
      appMediaDevice.themeData.textTheme.caption!.copyWith(fontSize: sp(12));

  TextStyle get overline =>
      appMediaDevice.themeData.textTheme.overline!.copyWith(fontSize: sp(10));

  TextStyle get titleActionTextStyle => TextStyle(fontSize: sp(16));

  double get titleActionIconSize => sp(20);

  ButtonStyle get elevatedButtonStyle => ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.all(sp(12)),
      ));

  ButtonStyle get dialogButtonStyle => ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.all(sp(12)),
      ));

  TextStyle get formFieldTextStyle => TextStyle(fontSize: sp18);

  TextStyle get textButtonTextStyle => TextStyle(fontSize: sp18);

  TextStyle get elevatedButtonTextStyle => TextStyle(fontSize: sp18);

  TextStyle get dialogButtonTextStyle => TextStyle(fontSize: sp18);

  TextStyle get formHelperTextStyle => TextStyle(
        height: 0.7,
        fontSize: sp16,
      );

  TextStyle get formLabelTextStyle => TextStyle(
    height: 0.7,
    fontSize: sp14,
  );

  TextStyle get formErrorTextStyle => TextStyle(
        height: 0.7,
        fontSize: sp16,
      );

  SizedBox get formFieldPaddingH => SizedBox(height: sp12);

  SizedBox get formFieldPaddingW => SizedBox(width: sp16);

  SizedBox get padding => SizedBox(height: sp16);

  EdgeInsets get allBoxPadding => EdgeInsets.all(
        sp16,
      );

  EdgeInsets get verticalBoxPadding => EdgeInsets.symmetric(
        vertical: sp16,
      );

  EdgeInsets get bottomBoxPadding => EdgeInsets.only(
        bottom: sp16,
      );
}

class MediaSettingsStateDefault extends MediaSettingsState {
  MediaSettingsStateDefault()
      : super(
          appMediaDevice: AppThemeConstants.defaultAppMediaDevice,
        );
}

class MediaSettingsStateUpdate extends MediaSettingsState {
  const MediaSettingsStateUpdate(AppMediaDevice appMediaDevice)
      : super(appMediaDevice: appMediaDevice);
}
