import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/user/user_dashboard.dart';
import 'package:single_store_app/src/app/models/user/user_notification_update.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class DashboardRepo extends AppRepo {
  DashboardRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<UserDashboard> getUserDashboard() async {
    return UserDashboard.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'user/dashboard',
        apiSegment: null,
      ),
    );
  }

  Future<UserNotificationUpdate> userNotificationUpdate({
    required UserNotificationUpdate userNotificationUpdate,
  }) async {
    return UserNotificationUpdate.fromJson(
      await httpPutJsonDecode(
        controllerSegment: 'store-user/notification-update',
        apiSegment: null,
        jsonObject: userNotificationUpdate,
      ),
    );
  }
}
