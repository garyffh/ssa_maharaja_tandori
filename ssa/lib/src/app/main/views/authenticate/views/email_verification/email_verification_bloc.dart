import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/models/authentication/sign_up_user.dart';
import 'package:single_store_app/src/app/models/authentication/verify_email.dart';
import 'package:single_store_app/src/app/models/authentication/verify_email_result.dart';

import 'email_verification_event.dart';
import 'email_verification_state.dart';

class EmailVerificationBloc
    extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  EmailVerificationBloc({
    required this.authenticationRepo,
    required this.authenticateNavCubit,
  }) : super(const EmailVerificationStateIdle()) {
    on<EmailVerificationEventSubmit>((event, emit) async {
      try {
        emit(const EmailVerificationStateProgressError());

        final VerifyEmail apiModel = VerifyEmail(
          firstName: event.signUpUser.firstName,
          lastName: event.signUpUser.lastName,
          emailAddress: event.signUpUser.email,
        );
        final VerifyEmailResult verifyEmailResult =
            await authenticationRepo.verifyEmail(content: apiModel);

        authenticateNavCubit.showEmailSignUp(
          signUpUser:
              event.signUpUser.copyWith(email: verifyEmailResult.emailAddress),
        );

        emit(const EmailVerificationStateIdle());
      } catch (e) {
        emit(EmailVerificationStateProgressError(error: e));
      }
    });

    on<EmailVerificationEventResetError>((event, emit) async {
      emit(const EmailVerificationStateIdle());
    });
  }

  final AuthenticationRepo authenticationRepo;
  final AuthenticateNavCubit authenticateNavCubit;
}
