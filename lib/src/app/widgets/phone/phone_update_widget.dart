import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/home/user_repo.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/phone/phone_update_widget_event.dart';

import 'phone_update_widget_bloc.dart';
import 'phone_update_widget_state.dart';

class PhoneUpdateWidget extends StatelessWidget {
  const PhoneUpdateWidget({
    required this.phoneUpdateConsumer,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  final Widget Function(
    BuildContext phoneUpdateWidgetContext,
    FormGroup phoneUpdateForm,
    PhoneUpdateWidgetState phoneUpdateWidgetState,
  ) phoneUpdateConsumer;
  final void Function(String mobileNumber)? onSubmitted;

  FormGroup buildForm() => fb.group(<String, Object>{
        'mobile': [
          '',
          Validators.required,
        ],
      });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneUpdateWidgetBloc(
        userRepo: context.read<UserRepo>(),
      ),
      child: _view(context),
    );
  }

  Widget _view(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _viewForm(context),
      ],
    );
  }

  Widget _viewForm(BuildContext context) {
    return BlocConsumer<PhoneUpdateWidgetBloc, PhoneUpdateWidgetState>(
      listener: (phoneUpdateWidgetContext, state) {
        if (onSubmitted != null) {
          if (state.type == ProgressErrorStateType.submitted) {
            onSubmitted!(
                (state as PhoneUpdateWidgetStateSubmitted).mobileNumber);
          }

          phoneUpdateWidgetContext.read<PhoneUpdateWidgetBloc>().add(
                PhoneUpdateWidgetEventResetError(),
              );
        }
      },
      builder: (viewContext, viewState) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: context.watch<MediaSettingsBloc>().state.formMaxWidth,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.watch<MediaSettingsBloc>().state.formPadding,
          ),
          child: ReactiveFormBuilder(
            form: buildForm,
            builder: (formContext, form, child) {
              return Column(
                children: [
                  _message(context),
                  context.watch<MediaSettingsBloc>().state.padding,
                  ReactiveTextField<String>(
                    keyboardType: TextInputType.phone,
                    style: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .formFieldTextStyle,
                    readOnly: viewState.formIsReadOnly,
                    formControlName: 'mobile',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'Mobile number is required',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Mobile number',
                      helperText: '',
                      helperStyle: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .formHelperTextStyle,
                      errorStyle: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .formErrorTextStyle,
                    ),
                  ),
                  context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
                  ReactiveFormConsumer(
                    builder: (formContext, form, child) {
                      return phoneUpdateConsumer(viewContext, form, viewState);
                    },
                  ),
                  context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
                  FormErrorMessageWidget(
                    errorMessage: viewState.stateErrorMessage(),
                  ),
                  context.watch<MediaSettingsBloc>().state.padding,
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _message(BuildContext context) {
    return Container(
      padding: context.watch<MediaSettingsBloc>().state.verticalBoxPadding,
      child: Column(
        children: [
          Text(
            'Enter your mobile number',
            style: context.watch<MediaSettingsBloc>().state.subtitle1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
