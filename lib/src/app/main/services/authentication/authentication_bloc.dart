import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/models/authentication/server_token.dart';
import 'package:single_store_app/src/app/services/app_repo_auth/app_repo_auth_cubit.dart';
import 'package:single_store_app/src/app/services/app_repo_auth/app_repo_auth_state.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_bloc.dart';
import 'package:single_store_app/src/app/services/storage/storage_cubit.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.storageCubit,
    required this.authenticationRepo,
    required this.appThemeBloc,
    required AppRepoAuthCubit appRepoAuthCubit,
  }) : super(const AuthenticationStateUnauthenticated()) {
    on<AuthenticationEventSignIn>((event, emit) async {
      try {
        emit(const AuthenticationStateProgressError());

        final ServerToken serverToken = await authenticationRepo.signIn(
          event.email,
          event.password,
        );

        await storageCubit.saveAccessToken(serverToken.accessToken);
        await storageCubit.saveRefreshToken(serverToken.refreshToken);

        emit(AuthenticationStateAuthenticated.copyWithServerToken(serverToken));
      } catch (e) {
        emit(AuthenticationStateProgressError(error: e));
      }
    });

    on<AuthenticationEventResetError>((event, emit) async {
      await storageCubit.removeAccessToken();
      await storageCubit.removeRefreshToken();

      emit(const AuthenticationStateUnauthenticated());
    });

    on<AuthenticationEventRefreshToken>((event, emit) async {
      try {
        if (state is AuthenticationStateUnauthenticated) {
          final String? refreshToken = await storageCubit.getRefreshToken();

          if (refreshToken != null) {
            final ServerToken serverToken =
                await authenticationRepo.refreshToken(refreshToken);

            await storageCubit.saveAccessToken(serverToken.accessToken);
            await storageCubit.saveRefreshToken(serverToken.refreshToken);

            emit(AuthenticationStateAuthenticated.copyWithServerToken(
                serverToken));
          }
        }
      } catch (_) {}
    });

    on<AuthenticationEventServerToken>((event, emit) async {
      emit(
        AuthenticationStateAuthenticated.copyWithServerToken(event.serverToken),
      );
    });

    on<AuthenticationEventSignOut>((event, emit) async {

      await authenticationRepo.disableDevice();
      await storageCubit.removeAccessToken();
      await storageCubit.removeRefreshToken();

      emit(AuthenticationStateUnauthenticated(
          signInMessage: event.signInMessage));
    });

    appRepoCubitSubscription = appRepoAuthCubit.stream.listen((state) {
      if (state is AppRepoAuthStateServerToken) {
        add(
          AuthenticationEventServerToken(
            serverToken: state.serverToken,
          ),
        );
      }

      if (state is AppRepoAuthStateSignOut) {
        add(AuthenticationEventSignOut(signInMessage: state.signInMessage));
      }
    });
  }

  final AuthenticationRepo authenticationRepo;
  final StorageCubit storageCubit;
  final AppThemeBloc appThemeBloc;
  late StreamSubscription appRepoCubitSubscription;

  @override
  Future<void> close() {
    appRepoCubitSubscription.cancel();
    return super.close();
  }
}
