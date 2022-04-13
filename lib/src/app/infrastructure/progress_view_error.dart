import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/constants/strings/failed_widget.constants.dart';
import 'package:single_store_app/src/app/constants/strings/maintenance_widget.constants.dart';
import 'package:single_store_app/src/app/constants/strings/no_internet_widget.constants.dart';
import 'package:single_store_app/src/app/infrastructure/progress_form_view.dart';

import 'app_exception.dart';

@immutable
abstract class ProgressViewError {
  const ProgressViewError({this.error});

  final dynamic error;

  List<String>? stateErrorMessage() {
    if (error == null) {
      return null;
    } else if (error.runtimeType == AppException) {
      return (error as AppException).message;
    } else if (error.runtimeType == SocketException) {
      return [
        noInternetWidgetTitle,
        noInternetWidgetLine1,
        noInternetWidgetLine2,
      ];
    } else if (error.runtimeType == HttpException) {
      return [
        maintenanceWidgetTitle,
        maintenanceWidgetLine1,
      ];
    } else if (error.runtimeType == FormatException) {
      return [
        maintenanceWidgetTitle,
        maintenanceWidgetLine1,
      ];
    } else {
      return [
        failedWidgetTitle,
        failedWidgetLine1,
        failedWidgetLine2,
      ];
    }
  }

  ProgressViewErrorType get progressViewErrorFromState {
    if (error == null) {
      return ProgressViewErrorType.progress;
    } else {
      switch (error.runtimeType) {
        case AppException:
          return ProgressViewErrorType.failedMessage;

        case SocketException:
          return ProgressViewErrorType.noInternet;

        case HttpException:
          return ProgressViewErrorType.maintenance;

        case FormatException:
          return ProgressViewErrorType.maintenance;

        default:
          return ProgressViewErrorType.failed;
      }
    }
  }
}
