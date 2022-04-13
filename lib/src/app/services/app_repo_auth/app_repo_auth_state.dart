
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:single_store_app/src/app/models/authentication/server_token.dart';

@immutable
abstract class AppRepoAuthState {
  const AppRepoAuthState();
}

class AppRepoAuthStateInitial extends AppRepoAuthState {
  const AppRepoAuthStateInitial() : super();
}

class AppRepoAuthStateServerToken extends AppRepoAuthState {
  const AppRepoAuthStateServerToken({
    required this.serverToken,
  }) : super();

  final ServerToken serverToken;
}

class AppRepoAuthStateSignOut extends AppRepoAuthState {
  const AppRepoAuthStateSignOut({
    this.signInMessage,
  }) : super();
  final List<String>? signInMessage;
}
