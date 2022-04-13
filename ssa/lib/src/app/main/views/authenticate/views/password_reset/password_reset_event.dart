abstract class PasswordResetEvent {
}


class PasswordResetEventSubmit extends PasswordResetEvent {
  PasswordResetEventSubmit({
    required this.code,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String code;
  final String email;
  final String password;
  final String confirmPassword;

}

class PasswordResetEventResetError extends PasswordResetEvent {
  PasswordResetEventResetError();

}
