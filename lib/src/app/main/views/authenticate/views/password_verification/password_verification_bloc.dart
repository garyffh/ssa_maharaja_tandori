import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_verification/password_verification_event.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_verification/password_verification_state.dart';
import 'package:single_store_app/src/app/models/authentication/verify_password.dart';
import 'package:single_store_app/src/app/models/authentication/verify_password_result.dart';

class PasswordVerificationBloc
    extends Bloc<PasswordVerificationEvent, PasswordVerificationState> {
  PasswordVerificationBloc({
    required this.authenticationRepo,
    required this.authenticateNavCubit,
  }) : super(const PasswordVerificationStateIdle()) {
    on<PasswordVerificationEventSubmit>((event, emit) async {

      try {

        emit(const PasswordVerificationStateProgressError());

        final VerifyPassword apiModel = VerifyPassword(email: event.email);

        final VerifyPasswordResult verifyPasswordResult =
            await authenticationRepo.verifyPassword(content: apiModel);

        authenticateNavCubit.showPasswordCode(
          email: verifyPasswordResult.email,
        );

        emit(const PasswordVerificationStateIdle());
      } catch (e) {
        emit(PasswordVerificationStateProgressError(error: e));
      }
    });

    on<PasswordVerificationEventResetError>((event, emit) async {
      emit(const PasswordVerificationStateIdle());
    });
  }

  final AuthenticationRepo authenticationRepo;
  final AuthenticateNavCubit authenticateNavCubit;

}
