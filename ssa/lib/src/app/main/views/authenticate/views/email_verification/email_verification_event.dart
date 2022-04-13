import 'package:single_store_app/src/app/models/authentication/sign_up_user.dart';

abstract class EmailVerificationEvent {}

class EmailVerificationEventSubmit extends EmailVerificationEvent {
  EmailVerificationEventSubmit({
    required this.signUpUser,
  });

  final SignUpUser signUpUser;
}

class EmailVerificationEventResetError extends EmailVerificationEvent {
  EmailVerificationEventResetError();
}
