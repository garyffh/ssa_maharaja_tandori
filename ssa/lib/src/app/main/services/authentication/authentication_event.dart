
import 'package:single_store_app/src/app/models/authentication/server_token.dart';

abstract class AuthenticationEvent {}

class AuthenticationEventSignIn extends AuthenticationEvent {
  AuthenticationEventSignIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class AuthenticationEventResetError extends AuthenticationEvent {
  AuthenticationEventResetError();

}

class AuthenticationEventRefreshToken extends AuthenticationEvent {
  AuthenticationEventRefreshToken();

}

class AuthenticationEventServerToken extends AuthenticationEvent {
  AuthenticationEventServerToken({
    required this.serverToken,
  });

  final ServerToken serverToken;
}

class AuthenticationEventSignOut extends AuthenticationEvent {
  AuthenticationEventSignOut({
    this.signInMessage,
  });

  final List<String>? signInMessage;
}
