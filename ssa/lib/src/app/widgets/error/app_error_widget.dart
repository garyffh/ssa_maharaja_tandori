import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/infrastructure/error_view.dart';
import 'package:single_store_app/src/app/infrastructure/error_view_type.dart';

import 'error_message_widget.dart';
import 'failed_widget.dart';
import 'maintenance_widget.dart';
import 'no_internet_widget.dart';


class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    required this.errorViewType,
    this.tryAgainCallback,
    this.errorMessage,
    Key? key,
  }) : super(key: key);

  AppErrorWidget.fromErrorView({
    required ErrorView errorView,
    this.tryAgainCallback,
    Key? key,
  }) : errorViewType = errorView.viewTypeFromError(),
        errorMessage = errorView.viewErrorMessage(),
        super(key: key);

  final ErrorViewType errorViewType;
  final VoidCallback? tryAgainCallback;
  final List<String>? errorMessage;

  @override
  Widget build(BuildContext context) {

    switch (errorViewType) {

      case ErrorViewType.failedMessage:
        return ErrorMessageWidget(
          errorMessage: errorMessage,
          tryAgainCallback: tryAgainCallback,
        );

      case ErrorViewType.failed:
        return FailedWidget(tryAgainCallback: tryAgainCallback);

      case ErrorViewType.maintenance:
        return MaintenanceWidget(tryAgainCallback: tryAgainCallback);

      case ErrorViewType.noInternet:
        return NoInternetWidget(tryAgainCallback: tryAgainCallback);

      default:
        return FailedWidget(tryAgainCallback: tryAgainCallback);
    }
  }
}
