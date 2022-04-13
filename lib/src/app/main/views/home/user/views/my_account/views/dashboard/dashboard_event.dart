import 'package:single_store_app/src/app/models/user/user_notification_update.dart';

abstract class DashboardEvent {}

class DashboardEventGetViewModel extends DashboardEvent {
  DashboardEventGetViewModel();

}

class DashboardEventUserNotificationUpdate extends DashboardEvent {
  DashboardEventUserNotificationUpdate({
    required this.userNotificationUpdate,
});

  final UserNotificationUpdate userNotificationUpdate;
}
