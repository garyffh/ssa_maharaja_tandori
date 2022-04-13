import 'package:json_annotation/json_annotation.dart';

part 'user_notification_update.g.dart';

@JsonSerializable()
class UserNotificationUpdate {
  UserNotificationUpdate({
    required this.typeId,
    required this.enabled,
  });

  factory UserNotificationUpdate.fromJson(Map<String, dynamic> json) => _$UserNotificationUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$UserNotificationUpdateToJson(this);

  final   int typeId;
  final   bool enabled;

}
