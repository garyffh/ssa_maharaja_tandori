import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';

enum ProgressViewErrorType {
  progress,
  failed,
  maintenance,
  noInternet,
  failedMessage,
}

@immutable
abstract class ProgressFormView {

  ProgressErrorStateType get viewType => ProgressErrorStateType.initial;
  bool get hasError => false;
  bool get inProgress => false;
  bool get formIsReadOnly => inProgress || hasError;

  List<String>? stateErrorMessage() => null;

  ProgressViewErrorType get progressViewErrorFromState => ProgressViewErrorType.progress;

}
