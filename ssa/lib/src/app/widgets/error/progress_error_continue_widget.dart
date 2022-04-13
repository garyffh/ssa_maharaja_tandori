import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/constants/strings/continue_button.constants.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/widgets/ui/progress_widget.dart';

import 'error_message_widget.dart';
import 'failed_widget.dart';
import 'maintenance_widget.dart';
import 'no_internet_widget.dart';

class ProgressErrorContinueWidget extends StatelessWidget {
  const ProgressErrorContinueWidget({
    required this.progressErrorState,
    required this.dataDirection,
    this.continueCallback,
    this.progressWidget,
    Key? key,
  }) : super(key: key);

  final ProgressErrorState progressErrorState;
  final VoidCallback? continueCallback;
  final Widget? progressWidget;
  final DataDirection dataDirection;

  @override
  Widget build(BuildContext context) {
    switch (progressErrorState.viewTypeFromState()) {
      case ProgressErrorViewType.progress:
        return progressWidget == null
            ? ProgressWidget(
                dataDirection: dataDirection,
              )
            : progressWidget!;

      case ProgressErrorViewType.failedMessage:
        return ErrorMessageWidget(
          errorMessage: progressErrorState.failedMessage(),
          tryAgainCallback: continueCallback,
          tryAgainButtonText: continueButtonText,
        );

      case ProgressErrorViewType.failed:
        return FailedWidget(
          tryAgainCallback: continueCallback,
          tryAgainButtonText: continueButtonText,
        );

      case ProgressErrorViewType.maintenance:
        return MaintenanceWidget(
          tryAgainCallback: continueCallback,
          tryAgainButtonText: continueButtonText,
        );

      case ProgressErrorViewType.noInternet:
        return NoInternetWidget(
          tryAgainCallback: continueCallback,
          tryAgainButtonText: continueButtonText,
        );
    }
  }
}
