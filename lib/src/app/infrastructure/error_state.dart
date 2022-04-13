import 'dart:io';

import 'app_exception.dart';
import 'error_view_type.dart';

abstract class ErrorState {


  ErrorViewType errorViewTypeFromError(dynamic error) {
    if(error.runtimeType == AppException) {
      return ErrorViewType.failedMessage;
    } else if (error.runtimeType == SocketException) {
      return ErrorViewType.noInternet;
    } else if (error.runtimeType == HttpException) {
      return ErrorViewType.maintenance;
    } else if (error.runtimeType == FormatException) {
      return ErrorViewType.maintenance;
    } else {
      return ErrorViewType.failed;
    }
  }

  List<String>? errorMessageFromException(dynamic e) {
    if(e.runtimeType == AppException) {
      return (e as AppException).message;
    } else {
      return null;
    }
  }

}
