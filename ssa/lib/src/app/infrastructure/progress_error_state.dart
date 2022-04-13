import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';

import 'app_exception.dart';


enum ProgressErrorViewType {
  progress,
  failed,
  maintenance,
  noInternet,
  failedMessage,
}

@immutable
abstract class ProgressErrorState {
  const ProgressErrorState({
    required this.type,
    this.error,
  });

  final ProgressErrorStateType type;
  final dynamic error;

  ProgressErrorViewType viewTypeFromState() {
    switch (type) {
      case ProgressErrorStateType.submitted:
      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.loaded:
      case ProgressErrorStateType.initial:
        {
          return ProgressErrorViewType.progress;
        }

      case ProgressErrorStateType.loadingError:
      case ProgressErrorStateType.progressError:
        {
          if (error.runtimeType == AppException) {
            return ProgressErrorViewType.failedMessage;
          } else if (error.runtimeType == SocketException) {
            return ProgressErrorViewType.noInternet;
          } else if (error.runtimeType == HttpException) {
            return ProgressErrorViewType.maintenance;
          } else if (error.runtimeType == FormatException) {
            return ProgressErrorViewType.maintenance;
          } else if (error != null) {
            return ProgressErrorViewType.failed;
          } else {
            return ProgressErrorViewType.progress;
          }
        }
    }
  }

  List<String>? failedMessage() {
    if (error.runtimeType == AppException) {
      return (error as AppException).message;
    } else {
      return null;
    }
  }
}
