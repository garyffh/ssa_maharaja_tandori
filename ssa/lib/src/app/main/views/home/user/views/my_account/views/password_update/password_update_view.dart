import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/constants/form_message.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_validators.dart';
import 'package:single_store_app/src/app/infrastructure/validators/app_validation_message.dart';
import 'package:single_store_app/src/app/main/repos/home/user_repo.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/home/user/views/my_account/my_account_nav_cubit.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/user/user_password_update.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

import 'password_update_bloc.dart';
import 'password_update_event.dart';
import 'password_update_state.dart';

class PasswordUpdateView extends StatelessWidget {
  const PasswordUpdateView({
    Key? key,
  }) : super(key: key);

  FormGroup buildForm() => FormGroup({
        'password': FormControl<String>(
          value: '',
          validators: AppValidators.passwordValidators,
        ),
        'newPassword': FormControl<String>(
          value: '',
          validators: AppValidators.passwordValidators,
        ),
        'confirmNewPassword': FormControl<String>(
          value: '',
        ),
      }, validators: [
        Validators.mustMatch('newPassword', 'confirmNewPassword'),
      ]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordUpdateBloc(
        userRepo: RepositoryProvider.of<UserRepo>(context),
        myAccountNavCubit: context.read<MyAccountNavCubit>(),
      ),
      child: SubView(
        title: 'Change Password',
        child: _view(context),
      ),
    );
  }

  Widget _view(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _viewForm(context),
        ),
      ],
    );
  }

  Widget _viewForm(BuildContext context) {
    return BlocBuilder<PasswordUpdateBloc, PasswordUpdateState>(
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
              final AuthenticationState authenticationState =
                  viewContext.read<AuthenticationBloc>().state;

              return Column(
                children: [
                  Expanded(
                    child: context.watch<MediaSettingsBloc>().state.padding,
                  ),
                  if (authenticationState is AuthenticationStateAuthenticated)
                    Container(
                      padding: EdgeInsets.only(
                          bottom: context
                              .watch<MediaSettingsBloc>()
                              .state
                              .formPadding),
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: NameValueWidget(
                        name: 'Email',
                        value: authenticationState.email,
                      ),
                    ),
                  ReactiveTextField<String>(
                    keyboardType: TextInputType.text,
                    style: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .formFieldTextStyle,
                    readOnly: viewState.formIsReadOnly,
                    formControlName: 'password',
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    validationMessages: (control) => {
                      ValidationMessage.required:
                      FormMessageConstants.passwordRequired,
                      ValidationMessage.minLength:
                      FormMessageConstants.passwordMinLength,
                      ValidationMessage.maxLength:
                      FormMessageConstants.passwordMaxLength,
                      AppValidationMessage.numberRequired:
                      FormMessageConstants.passwordNumberRequired,
                      AppValidationMessage.upperRequired:
                      FormMessageConstants.passwordUpperRequired,
                      AppValidationMessage.lowerRequired:
                      FormMessageConstants.passwordLowerRequired,
                    },
                    decoration: InputDecoration(
                      labelText: 'Existing password',
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
                  ReactiveTextField<String>(
                    keyboardType: TextInputType.text,
                    style: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .formFieldTextStyle,
                    readOnly: viewState.formIsReadOnly,
                    formControlName: 'newPassword',
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    validationMessages: (control) => {
                      ValidationMessage.required:
                      FormMessageConstants.passwordRequired,
                      ValidationMessage.minLength:
                      FormMessageConstants.passwordMinLength,
                      ValidationMessage.maxLength:
                      FormMessageConstants.passwordMaxLength,
                      AppValidationMessage.numberRequired:
                      FormMessageConstants.passwordNumberRequired,
                      AppValidationMessage.upperRequired:
                      FormMessageConstants.passwordUpperRequired,
                      AppValidationMessage.lowerRequired:
                      FormMessageConstants.passwordLowerRequired,
                    },
                    decoration: InputDecoration(
                      labelText: 'New password',
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
                  ReactiveTextField<String>(
                    keyboardType: TextInputType.text,
                    style: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .formFieldTextStyle,
                    readOnly: viewState.formIsReadOnly,
                    formControlName: 'confirmNewPassword',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    validationMessages: (control) => {
                      ValidationMessage.mustMatch: FormMessageConstants.passwordConfirmationMustMatch,
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirm new password',
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
                      return FormProgressButton(
                        text: 'Submit',
                        progressFormView: viewState,
                        onPressed: onPressedSubmitButton(
                          viewContext,
                          form,
                          viewState,
                        ),
                        dataDirection: DataDirection.none,
                      );
                    },
                  ),
                  context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
                  FormErrorMessageWidget(
                    errorMessage: viewState.stateErrorMessage(),
                  ),
                  Expanded(
                    child: context.watch<MediaSettingsBloc>().state.padding,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext viewContext,
    FormGroup form,
    PasswordUpdateState viewState,
  ) {
    return form.valid
        ? () {
            if (viewState.hasError) {
              viewContext
                  .read<PasswordUpdateBloc>()
                  .add(PasswordUpdateEventResetError());
            } else if (!viewState.inProgress) {
              final AuthenticationState authenticationState =
                  viewContext.read<AuthenticationBloc>().state;

              if (authenticationState is AuthenticationStateAuthenticated) {
                viewContext.read<PasswordUpdateBloc>().add(
                      PasswordUpdateEventSubmit(
                        userPasswordUpdate: UserPasswordUpdate(
                          email: authenticationState.email,
                          password: (form.value['password']! as String).trim(),
                          newPassword:
                              (form.value['newPassword']! as String).trim(),
                          confirmNewPassword:
                              (form.value['confirmNewPassword']! as String)
                                  .trim(),
                        ),
                      ),
                    );
              }
            }
          }
        : null;
  }
}
