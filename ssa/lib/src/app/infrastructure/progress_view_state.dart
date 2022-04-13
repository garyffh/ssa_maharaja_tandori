import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_form_view.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_error.dart';

@immutable
abstract class ProgressViewState extends ProgressViewError implements ProgressFormView {
  const ProgressViewState({
    required this.type,
    dynamic error,
  }): super(error: error);

  final ProgressErrorStateType type;

  @override
  ProgressErrorStateType get viewType => type;

  @override
  bool get hasError => error != null;

  @override
  bool get inProgress => type == ProgressErrorStateType.progressError && error == null;

  @override
  bool get formIsReadOnly => inProgress || hasError;


}
