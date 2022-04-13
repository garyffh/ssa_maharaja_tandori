
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/authentication/server_token.dart';

import 'app_repo_auth_state.dart';


class AppRepoAuthCubit extends Cubit<AppRepoAuthState> {
  AppRepoAuthCubit() : super(const AppRepoAuthStateInitial());

  void updateServerToken(ServerToken serverToken) => emit(
    AppRepoAuthStateServerToken(
      serverToken: serverToken,
    ),
  );

  void signOut(List<String>? signInMessage) =>
      emit(AppRepoAuthStateSignOut(signInMessage: signInMessage));
}
