import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';
import 'package:single_store_app/src/app/models/authentication/server_token.dart';

@immutable
abstract class AuthenticationState extends ProgressViewState {
  const AuthenticationState({
    required ProgressErrorStateType type,
    dynamic error,
    required this.isAuthenticated,
    this.ceo = false,
    this.admin = false,
    this.driver = false,
    this.waiter = false,
  }) : super(type: type, error: error);

  final bool isAuthenticated;
  final bool ceo;
  final bool admin;
  final bool driver;
  final bool waiter;

  int? get userPriceLevel => null;

}

class AuthenticationStateUnauthenticated extends AuthenticationState {
  const AuthenticationStateUnauthenticated({
    this.signInMessage,
  }) : super(
          type: ProgressErrorStateType.idle,
          isAuthenticated: false,
        );
  final List<String>? signInMessage;
}

class AuthenticationStateProgressError extends AuthenticationState {
  const AuthenticationStateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
          isAuthenticated: false,
        );
}

class AuthenticationStateAuthenticated extends AuthenticationState {
  const AuthenticationStateAuthenticated({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.cardNumber,
  }) : super(
          type: ProgressErrorStateType.submitted,
          isAuthenticated: true,
        );

  AuthenticationStateAuthenticated.copyWithServerToken(ServerToken instance)
      : email = instance.userName,
        firstName = instance.firstName,
        lastName = instance.lastName,
        cardNumber = instance.cardNumber,
        super(
          type: ProgressErrorStateType.submitted,
          isAuthenticated: true,
          ceo: instance.ceo == 'True',
          admin: instance.admin == 'True',
          driver: instance.driver == 'True',
          waiter: instance.waiter == 'True',
        );

  final String email;
  final String firstName;
  final String lastName;
  final String cardNumber;
}
