import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/user/credit_detail.dart';

@immutable
abstract class CreditDetailState extends ProgressErrorState {
  const CreditDetailState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class CreditDetailStateInitial extends CreditDetailState {
  const CreditDetailStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class CreditDetailStateLoadingError extends CreditDetailState {
  const CreditDetailStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class CreditDetailStateViewModel extends CreditDetailState {
  const CreditDetailStateViewModel({
    required this.creditDetail,
  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final CreditDetail creditDetail;
}
