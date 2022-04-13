import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/driver/trn_delivery.dart';

@immutable
abstract class DriverDeliveryDetailState extends ProgressErrorState {
  const DriverDeliveryDetailState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class DriverDeliveryDetailStateInitial extends DriverDeliveryDetailState {
  const DriverDeliveryDetailStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class DriverDeliveryDetailStateLoadingError extends DriverDeliveryDetailState {
  const DriverDeliveryDetailStateLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );
}

abstract class DriverDeliveryDetailStateViewModel
    extends DriverDeliveryDetailState {
  const DriverDeliveryDetailStateViewModel({
    required this.trnDelivery,
    dynamic error,
    required ProgressErrorStateType type,
  }) : super(
          error: error,
          type: type,
        );

  final TrnDelivery trnDelivery;
}

class DriverDeliveryDetailStateViewLoaded
    extends DriverDeliveryDetailStateViewModel {
  const DriverDeliveryDetailStateViewLoaded({
    required TrnDelivery trnDelivery,
  }) : super(
          trnDelivery: trnDelivery,
          type: ProgressErrorStateType.loaded,
        );
}

class DriverDeliveryDetailStateProgressError
    extends DriverDeliveryDetailStateViewModel {
  const DriverDeliveryDetailStateProgressError({
    required TrnDelivery trnDelivery,
    dynamic error,
  }) : super(
          trnDelivery: trnDelivery,
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}
