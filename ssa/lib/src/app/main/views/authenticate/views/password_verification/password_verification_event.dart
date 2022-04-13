abstract class PasswordVerificationEvent {}

class PasswordVerificationEventSubmit extends PasswordVerificationEvent {
  PasswordVerificationEventSubmit({
    required this.email,
  });

  final String email;
}

class PasswordVerificationEventResetError extends PasswordVerificationEvent {
  PasswordVerificationEventResetError();
}
