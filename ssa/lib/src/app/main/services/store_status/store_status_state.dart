import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/models/business/open_status.dart';
import 'package:single_store_app/src/app/models/business/store_status.dart';

@immutable
abstract class StoreStatusState {
  const StoreStatusState({
    required this.loaded,
    required this.timeZone,
  });

  final bool loaded;
  final String timeZone;

  bool get closed => true;
}

class StoreStatusStatePending extends StoreStatusState {
  const StoreStatusStatePending()
      : super(
          loaded: false,
          timeZone: '',
        );
}

class StoreStatusStatePendingError extends StoreStatusStatePending {
  const StoreStatusStatePendingError({
    required this.error,
  }) : super();
  final dynamic error;
}

class StoreStatusStateLoaded extends StoreStatusState {
  const StoreStatusStateLoaded({
    required this.storeStatus,
    required String timeZone,
  }) : super(
          loaded: true,
          timeZone: timeZone,
        );

  final StoreStatus storeStatus;

  @override
  bool get closed => storeStatus.openStatus != OpenStatus.open;
}

class StoreStatusStateImmediateRefreshError extends StoreStatusStateLoaded {
  const StoreStatusStateImmediateRefreshError({
    required StoreStatus storeStatus,
    required String timeZone,
    required this.error,
  }) : super(
          storeStatus: storeStatus,
          timeZone: timeZone,
        );

  final dynamic error;
}
