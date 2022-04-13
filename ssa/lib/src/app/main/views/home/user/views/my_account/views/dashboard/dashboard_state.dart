import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';
import 'package:single_store_app/src/app/models/user/user_dashboard.dart';

@immutable
abstract class DashboardState extends ProgressViewState {
  const DashboardState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class DashboardStateInitial extends DashboardState {
  const DashboardStateInitial()
      : super(
          type: ProgressErrorStateType.initial,
        );
}

class DashboardStateLoadingError extends DashboardState {
  const DashboardStateLoadingError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.loadingError,
          error: error,
        );
}

abstract class DashboardStateViewModel extends DashboardState {
  const DashboardStateViewModel({
    required this.userDashboard,
    dynamic error,
    required ProgressErrorStateType type,
  }) : super(
    error: error,
    type: type,
        );

  final UserDashboard userDashboard;
}


class DashboardStateViewLoaded extends DashboardStateViewModel {
  const DashboardStateViewLoaded({
    required UserDashboard userDashboard,
  }) : super(
    userDashboard: userDashboard,
    type: ProgressErrorStateType.loaded,
  );

}

class DashboardStateViewProgressError extends DashboardStateViewModel {
  const DashboardStateViewProgressError({
    required UserDashboard userDashboard,
    dynamic error,
  }) : super(
    userDashboard: userDashboard,
    type: ProgressErrorStateType.progressError,
    error: error,
  );

}
