import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/infrastructure/progress_form_view.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/widgets/error/error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/error/failed_widget.dart';
import 'package:single_store_app/src/app/widgets/error/maintenance_widget.dart';
import 'package:single_store_app/src/app/widgets/error/no_internet_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/progress_widget.dart';

class FormLoadingErrorWidget extends StatelessWidget {
  const FormLoadingErrorWidget({
    required this.progressFormView,
    this.dataDirection = DataDirection.receiving,
    this.tryAgainCallback,
    this.progressWidget,
    Key? key,
  }) : super(key: key);

  final ProgressFormView progressFormView;
  final VoidCallback? tryAgainCallback;
  final Widget? progressWidget;
  final DataDirection dataDirection;

  @override
  Widget build(BuildContext context) {
    switch (progressFormView.progressViewErrorFromState) {
      case ProgressViewErrorType.progress:
        return progressWidget == null
            ? ProgressWidget(
                dataDirection: dataDirection,
              )
            : progressWidget!;

      case ProgressViewErrorType.failedMessage:
        return ErrorMessageWidget(
          errorMessage: progressFormView.stateErrorMessage(),
          tryAgainCallback: tryAgainCallback,
        );

      case ProgressViewErrorType.failed:
        return FailedWidget(tryAgainCallback: tryAgainCallback);

      case ProgressViewErrorType.maintenance:
        return MaintenanceWidget(tryAgainCallback: tryAgainCallback);

      case ProgressViewErrorType.noInternet:
        return NoInternetWidget(tryAgainCallback: tryAgainCallback);
    }
  }
}
