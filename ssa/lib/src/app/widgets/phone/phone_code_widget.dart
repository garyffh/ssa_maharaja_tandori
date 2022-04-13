import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/user_repo.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/pin_code_entry_widget.dart';

import 'phone_code_widget_bloc.dart';
import 'phone_code_widget_event.dart';
import 'phone_code_widget_state.dart';

class PhoneCodeWidget extends StatelessWidget {
  const PhoneCodeWidget({
    required this.mobileNumber,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  final String mobileNumber;
  final void Function(String mobileNumber)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneCodeWidgetBloc(
        userRepo: context.read<UserRepo>(),
      ),
      child: BlocConsumer<PhoneCodeWidgetBloc, PhoneCodeWidgetState>(
        listener: (phoneCodeWidgetContext, state) {
          if (state.type == ProgressErrorStateType.submitted) {
            if (onSubmitted != null) {
              onSubmitted!(
                  (state as PhoneCodeWidgetStateSubmitted).mobileNumber);
            }

            phoneCodeWidgetContext.read<PhoneCodeWidgetBloc>().add(
                  PhoneCodeWidgetEventResetError(),
                );
          }
        },
        builder: (viewContext, state) {
          return _view(viewContext, state);
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, PhoneCodeWidgetState viewState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        viewContext.watch<MediaSettingsBloc>().state.padding,
        _message(viewContext),
        viewContext.watch<MediaSettingsBloc>().state.padding,
        _viewForm(),
      ],
    );
  }

  Widget _message(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.watch<MediaSettingsBloc>().state.formPadding),
      child: Column(
        children: [
          Text(
            'We sent an sms to',
            style: context.watch<MediaSettingsBloc>().state.subtitle2,
            textAlign: TextAlign.center,
          ),
          SizedBox(
              height: context.watch<MediaSettingsBloc>().state.smallPadding),
          Text(
            mobileNumber,
            style: context.watch<MediaSettingsBloc>().state.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
              height: context.watch<MediaSettingsBloc>().state.smallPadding),
          Text(
            'Enter the six digit verification code sent.',
            style: context.watch<MediaSettingsBloc>().state.subtitle2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _viewForm() {
    return BlocBuilder<PhoneCodeWidgetBloc, PhoneCodeWidgetState>(
      builder: (context, viewState) {
        switch (viewState.type) {
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

          case ProgressErrorStateType.progressError:
            return FormProgressErrorWidget(
              progressFormView: viewState,
              tryAgainCallback: () => context
                  .read<PhoneCodeWidgetBloc>()
                  .add(PhoneCodeWidgetEventResetError()),
            );

          case ProgressErrorStateType.loaded:
          case ProgressErrorStateType.loadingError:
          case ProgressErrorStateType.initial:
            {
              return const UnhandledStateWidget();
            }
        }
      },
    );
  }

  void _onSubmitCode(BuildContext context, String? code) {
    if (code != null) {
      context.read<PhoneCodeWidgetBloc>().add(PhoneCodeWidgetEventSubmit(
            mobileNumber: mobileNumber,
            mobileCode: code,
          ));
    }
  }
}
