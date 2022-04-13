import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/models/authentication/sign_up_user.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/pin_code_entry_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

import 'email_sign_up_bloc.dart';
import 'email_sign_up_event.dart';
import 'email_sign_up_state.dart';

class EmailSignUpView extends StatelessWidget {
  const EmailSignUpView({
    required this.signUpUser,
    Key? key,
  }) : super(key: key);

  final SignUpUser signUpUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailSignUpBloc(
        authenticationRepo: context.read<AuthenticationRepo>(),
        authenticateNavCubit: context.read<AuthenticateNavCubit>(),
      ),
      child: SubView(
        title: 'Email Verification',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            context.watch<MediaSettingsBloc>().state.padding,
            _message(context),
            context.watch<MediaSettingsBloc>().state.padding,
            Expanded(
              child: _viewForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _message(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.watch<MediaSettingsBloc>().state.formPadding),
      child: Column(
        children: [
          Text(
            'To verify your email address,',
            style: context.watch<MediaSettingsBloc>().state.subtitle2,
            textAlign: TextAlign.center,
          ),
          Text(
            'we sent an email to',
            style: context.watch<MediaSettingsBloc>().state.subtitle2,
            textAlign: TextAlign.center,
          ),
          SizedBox(
              height: context.watch<MediaSettingsBloc>().state.smallPadding),
          Text(
            signUpUser.email,
            style: context.watch<MediaSettingsBloc>().state.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
              height: context.watch<MediaSettingsBloc>().state.smallPadding),
          Text(
            'Enter the emailed six digit code.',
            style: context.watch<MediaSettingsBloc>().state.subtitle2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _viewForm() {
    return BlocBuilder<EmailSignUpBloc, EmailSignUpState>(
      builder: (context, viewState) {
        switch (viewState.type) {
          case ProgressErrorStateType.initial:
          case ProgressErrorStateType.loaded:
          case ProgressErrorStateType.submitted:
            return FormProgressErrorWidget(
              progressFormView: viewState,
            );

          case ProgressErrorStateType.idle:
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      context.watch<MediaSettingsBloc>().state.formPadding),
              child: PinCodeEntryWidget(
                onSubmit: (code) => _onSubmitCode(context, code),
              ),
            );

          case ProgressErrorStateType.loadingError:
          case ProgressErrorStateType.progressError:
            return FormProgressErrorWidget(
              progressFormView: viewState,
              tryAgainCallback: () =>
                  context.read<AuthenticateNavCubit>().showEmailVerification(),
            );
        }
      },
    );
  }

  void _onSubmitCode(BuildContext context, String? code) {
    if (code != null) {
      context.read<EmailSignUpBloc>().add(EmailSignUpEventSubmit(
            signUpUser: signUpUser.copyWith(),
            emailCode: code,
          ));
    }
  }
}
