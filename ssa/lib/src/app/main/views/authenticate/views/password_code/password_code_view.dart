import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_code/password_code_bloc.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_code/password_code_event.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_code/password_code_state.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/pin_code_entry_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

class PasswordCodeView extends StatelessWidget {
  const PasswordCodeView({
    required this.email,
    Key? key,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PasswordCodeBloc(
          authenticateNavCubit: context.read<AuthenticateNavCubit>(),
        ),
        child: SubView(
          title: 'Reset Code',
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
            'If you have previously registered',
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
            email,
            style: context.watch<MediaSettingsBloc>().state.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
              height: context.watch<MediaSettingsBloc>().state.smallPadding),
          Text(
            'Enter the emailed six digit verification code.',
            style: context.watch<MediaSettingsBloc>().state.subtitle2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _viewForm() {
    return BlocBuilder<PasswordCodeBloc, PasswordCodeState>(
      builder: (context, viewState) {
        switch (viewState.type) {
          case ProgressErrorStateType.initial:
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

          case ProgressErrorStateType.progressError:
            return FormProgressErrorWidget(
              progressFormView: viewState,
              tryAgainCallback: () => context
                  .read<PasswordCodeBloc>()
                  .add(PasswordCodeEventResetError()),
            );

          case ProgressErrorStateType.loaded:
          case ProgressErrorStateType.submitted:
          case ProgressErrorStateType.loadingError:
            {
              return const UnhandledStateWidget();
            }

        }
      },
    );
  }

  void _onSubmitCode(BuildContext context, String? code) {
    if (code != null) {
      context.read<PasswordCodeBloc>().add(PasswordCodeEventSubmit(
            email: email,
            code: code,
          ));
    }
  }
}
