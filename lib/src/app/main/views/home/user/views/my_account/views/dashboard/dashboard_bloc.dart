import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/text.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_exception.dart';
import 'package:single_store_app/src/app/main/repos/home/dashboard_repo.dart';
import 'package:single_store_app/src/app/models/user/user_dashboard.dart';
import 'package:single_store_app/src/app/models/user/user_notification_update.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.dashboardRepo})
      : super(const DashboardStateInitial()) {
    on<DashboardEventGetViewModel>((event, emit) async {
      try {
        emit(const DashboardStateLoadingError());

        final UserDashboard userDashboard =
            await dashboardRepo.getUserDashboard();

        emit(DashboardStateViewLoaded(userDashboard: userDashboard));
      } catch (e) {
        emit(DashboardStateLoadingError(error: e));
      }
    });

    on<DashboardEventUserNotificationUpdate>((event, emit) async {
      if (state is DashboardStateViewModel) {
        final UserDashboard userDashboard =
            (state as DashboardStateViewModel).userDashboard;

        try {
          emit(DashboardStateViewProgressError(
            userDashboard: userDashboard,
          ));

          final UserNotificationUpdate userNotificationUpdate =
              await dashboardRepo.userNotificationUpdate(
            userNotificationUpdate: event.userNotificationUpdate,
          );

          emit(DashboardStateViewLoaded(
            userDashboard: UserDashboard.updateSpecialDeals(
              specialDeals: userNotificationUpdate.enabled,
              userDashboard: userDashboard,
            ),
          ));
        } catch (e) {
          emit(DashboardStateViewProgressError(
            userDashboard: userDashboard,
            error: e,
          ));
        }
      } else {
        emit(DashboardStateLoadingError(
          error: AppException.fromString(unexpectedBlocState),
        ));
      }
    });
  }

  final DashboardRepo dashboardRepo;

}
