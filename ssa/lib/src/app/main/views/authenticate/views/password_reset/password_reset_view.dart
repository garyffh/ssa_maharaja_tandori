import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/constants/form_message.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_validators.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/validators/app_validation_message.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_reset/password_reset_bloc.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_reset/password_reset_event.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_reset/password_reset_state.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

class PasswordResetView extends StatelessWidget {
  const PasswordResetView({
    required this.email,
    required this.code,
    Key? key,
  }) : super(key: key);

  final String email;
  final String code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetBloc(
        authenticationRepo: context.read<AuthenticationRepo>(),
        authenticateNavCubit: context.read<AuthenticateNavCubit>(),
      ),
      child: SubView(
        title: 'Password Reset',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _message(context),
            _viewForm(context),
          ],
        ),
      ),
    );
  }

  Widget _message(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.watch<MediaSettingsBloc>().state.formMaxWidth,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: context.watch<MediaSettingsBloc>().state.formPadding),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Container(
                      padding: EdgeInsets.all(
                        context.watch<MediaSettingsBloc>().state.sp10,
                      ),
                      child: Text(
                        'Email:',
                        style: context
                            .watch<MediaSettingsBloc>()
                            .state
                            .bodyText1
                            .bold,
                        textAlign: TextAlign.right,
                      ))),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Container(
                  padding: EdgeInsets.all(
                    context.watch<MediaSettingsBloc>().state.sp10,
                  ),
                  child: Text(
                    email,
                    style: context.watch<MediaSettingsBloc>().state.bodyText1,
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: <Widget>[
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Container(
                  padding: EdgeInsets.all(
                    context.watch<MediaSettingsBloc>().state.sp10,
                  ),
                  child: Text(
                    'Code:',
                    style:
                        context.watch<MediaSettingsBloc>().state.bodyText1.bold,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Container(
                  padding: EdgeInsets.all(
                    context.watch<MediaSettingsBloc>().state.sp10,
                  ),
                  child: Text(
                    code,
                    style: context.watch<MediaSettingsBloc>().state.bodyText1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _viewForm(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.watch<MediaSettingsBloc>().state.formMaxWidth,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: context.watch<MediaSettingsBloc>().state.formPadding),
      child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
        builder: (context, viewState) {
          return ReactiveFormBuilder(
              form: buildForm,
              builder: (formContext, form, child) {
                return Column(
                  children: [
                    context.watch<MediaSettingsBloc>().state.padding,
                    ReactiveTextField<String>(
                      style: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .formFieldTextStyle,
                      readOnly: viewState.formIsReadOnly,
                      formControlName: 'password',
                      obscureText: true,
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
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                      style: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .formFieldTextStyle,
                      readOnly: viewState.formIsReadOnly,
                      formControlName: 'confirmPassword',
                      obscureText: true,
                      validationMessages: (control) => {
                        ValidationMessage.mustMatch: FormMessageConstants.passwordConfirmationMustMatch,
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                          text: 'Reset Password',
                          progressFormView: viewState,
                          onPressed: onPressedSubmitButton(
                            context,
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
                    context.watch<MediaSettingsBloc>().state.padding,
                  ],
                );
              });
        },
      ),
    );
  }

  FormGroup buildForm() => FormGroup({
        'password': FormControl<String>(
          value: '',
          validators: AppValidators.passwordValidators,
        ),
        'confirmPassword': FormControl<String>(
          value: '',
        ),
      }, validators: [
        Validators.mustMatch('password', 'confirmPassword'),
      ]);

  VoidCallback? onPressedSubmitButton(
    BuildContext context,
    FormGroup form,
    PasswordResetState viewState,
  ) {
    return form.valid
        ? () {
            if (viewState.hasError) {
              context
                  .read<PasswordResetBloc>()
                  .add(PasswordResetEventResetError());
            } else if (!viewState.inProgress) {
              context.read<PasswordResetBloc>().add(PasswordResetEventSubmit(
                    code: code,
                    email: email,
                    password: (form.value['password']! as String).trim(),
                    confirmPassword:
                        (form.value['confirmPassword']! as String).trim(),
                  ));
            }
          }
        : null;
  }
}
