import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/widgets/ui/progress_widget.dart';

import 'error_message_widget.dart';
import 'failed_widget.dart';
import 'maintenance_widget.dart';
import 'no_internet_widget.dart';

class ProgressErrorWidget extends StatelessWidget {
  const ProgressErrorWidget({
    required this.progressErrorState,
    required this.dataDirection,
    this.tryAgainCallback,
    this.progressWidget,
    Key? key,
  }) : super(key: key);

  final ProgressErrorState progressErrorState;
  final VoidCallback? tryAgainCallback;
  final Widget? progressWidget;
  final DataDirection dataDirection;

  @override
  Widget build(BuildContext context) {
    switch (progressErrorState.viewTypeFromState()) {
      case ProgressErrorViewType.progress:
        return progressWidget == null
            ? ProgressWidget(dataDirection: dataDirection,)
            : progressWidget!;

      case ProgressErrorViewType.failedMessage:
        return ErrorMessageWidget(
          errorMessage: progressErrorState.failedMessage(),
          tryAgainCallback: tryAgainCallback,
        );

      case ProgressErrorViewType.failed:
        return FailedWidget(tryAgainCallback: tryAgainCallback);

      case ProgressErrorViewType.maintenance:
        return MaintenanceWidget(tryAgainCallback: tryAgainCallback);

      case ProgressErrorViewType.noInternet:
        return NoInternetWidget(tryAgainCallback: tryAgainCallback);
    }
  }
}
