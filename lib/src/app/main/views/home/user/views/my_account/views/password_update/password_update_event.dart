import 'package:single_store_app/src/app/models/user/user_password_update.dart';

abstract class PasswordUpdateEvent {}

class PasswordUpdateEventSubmit extends PasswordUpdateEvent {
  PasswordUpdateEventSubmit({
    required this. userPasswordUpdate,
});

  final UserPasswordUpdate userPasswordUpdate;
}

class PasswordUpdateEventResetError extends PasswordUpdateEvent {
  PasswordUpdateEventResetError();
}
