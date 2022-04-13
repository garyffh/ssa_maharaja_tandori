import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/models/authentication/email_sign_up.dart';
import 'package:single_store_app/src/app/models/authentication/signed_up_user.dart';

import 'email_sign_up_event.dart';
import 'email_sign_up_state.dart';

class EmailSignUpBloc extends Bloc<EmailSignUpEvent, EmailSignUpState> {
  EmailSignUpBloc({
    required this.authenticationRepo,
    required this.authenticateNavCubit,
  }) : super(const EmailSignUpStateIdle()) {
    on<EmailSignUpEventSubmit>((event, emit) async {
      try {
        emit(const EmailSignUpStateProgressError());

        final EmailSignUp apiModel = EmailSignUp(
          firstName: event.signUpUser.firstName,
          lastName: event.signUpUser.lastName,
          email: event.signUpUser.email,
          password: event.signUpUser.password,
          confirmPassword: event.signUpUser.confirmPassword,
          emailCode: event.emailCode,
        );

        await authenticationRepo.emailSignUp(content: apiModel);

        emit(const EmailSignUpStateIdle());

        authenticateNavCubit.showSignUpConfirmation(
          signedUpUser: SignedUpUser(
            firstName: event.signUpUser.firstName,
            email: event.signUpUser.email,
            password: event.signUpUser.password,
          ),
        );
      } catch (e) {
        emit(EmailSignUpStateProgressError(error: e));
      }
    });

  }

  final AuthenticationRepo authenticationRepo;
  final AuthenticateNavCubit authenticateNavCubit;
}
