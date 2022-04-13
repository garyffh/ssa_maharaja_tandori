import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_reset/password_reset_event.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_reset/password_reset_state.dart';
import 'package:single_store_app/src/app/models/authentication/password_reset.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc({
    required this.authenticationRepo,
    required this.authenticateNavCubit,
  }) : super(const PasswordResetStateIdle()) {
    on<PasswordResetEventSubmit>((event, emit) async {

      try {

        emit(const PasswordResetStateProgressError());

        final PasswordReset apiModel = PasswordReset(
          code: event.code,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );

        await authenticationRepo.resetPassword(content: apiModel);

        emit(const PasswordResetStateIdle());

        authenticateNavCubit.showPasswordResetConfirmation();
      } catch (e) {
        emit(PasswordResetStateProgressError(error: e));
      }
    });

    on<PasswordResetEventResetError>((event, emit) async {
      emit(const PasswordResetStateIdle());
    });
  }

  final AuthenticationRepo authenticationRepo;
  final AuthenticateNavCubit authenticateNavCubit;

}
