abstract class PasswordCodeEvent {
}


class PasswordCodeEventSubmit extends PasswordCodeEvent {
  PasswordCodeEventSubmit({
    required this.email,
    required this.code,
  });

  final String  email;
  final String  code;

}

class PasswordCodeEventResetError extends PasswordCodeEvent {
  PasswordCodeEventResetError();

}
