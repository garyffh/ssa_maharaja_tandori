import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/constants/form_message.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_validators.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/validators/app_validation_message.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/widgets/sign_in_button.dart';
import 'package:single_store_app/src/app/models/authentication/sign_up_user.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/view/primary_view.dart';

import 'email_verification_bloc.dart';
import 'email_verification_event.dart';
import 'email_verification_state.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailVerificationView();
}

class _EmailVerificationView extends State<EmailVerificationView> {
  final FormGroup form = fb.group(<String, Object>{
    'firstName': [
      '',
      Validators.required,
      Validators.minLength(3),
    ],
    'lastName': [
      '',
      Validators.required,
      Validators.minLength(3),
    ],
    'email': [
      '',
      Validators.required,
      AppValidators.emailTrim,
    ],
    'password': [
      '',
      ...AppValidators.passwordValidators,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailVerificationBloc(
        authenticationRepo: context.read<AuthenticationRepo>(),
        authenticateNavCubit: context.read<AuthenticateNavCubit>(),
      ),
      child: PrimaryView(
        title: 'Register',
        child: _viewModel(context),
      ),
    );
  }

  Widget _viewModel(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _viewForm(context),
        const SignInButton(),
      ],
    );
  }

  Widget _viewForm(BuildContext context) {
    return BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
      listener: (context, state) {
        if (state.viewType == ProgressErrorStateType.idle) {
          form.control('password').reset();
        }
      },
      builder: (context, viewState) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: context.watch<MediaSettingsBloc>().state.formMaxWidth,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: context.watch<MediaSettingsBloc>().state.formPadding),
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              children: [
                context.watch<MediaSettingsBloc>().state.padding,
                ReactiveTextField<String>(
                  style: context
                      .watch<MediaSettingsBloc>()
                      .state
                      .formFieldTextStyle,
                  readOnly: viewState.formIsReadOnly,
                  formControlName: 'firstName',
                  validationMessages: (control) => {
                    ValidationMessage.required: FormMessageConstants.firstNameRequired,
                    ValidationMessage.minLength: FormMessageConstants.firstMinLength,
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'First Name',
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
                  formControlName: 'lastName',
                  validationMessages: (control) => {
                    ValidationMessage.required: FormMessageConstants.lastNameRequired,
                    ValidationMessage.minLength: FormMessageConstants.lastMinLength,
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
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
                  formControlName: 'email',
                  validationMessages: (control) => {
                    ValidationMessage.required: FormMessageConstants.emailRequired,
                    ValidationMessage.email: FormMessageConstants.emailValid,
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  formControlName: 'password',
                  obscureText: true,
                  validationMessages: (control) => {
                    ValidationMessage.required: FormMessageConstants.passwordRequired,
                    ValidationMessage.minLength: FormMessageConstants.passwordMinLength,
                    ValidationMessage.maxLength: FormMessageConstants.passwordMaxLength,
                    AppValidationMessage.numberRequired: FormMessageConstants.passwordNumberRequired,
                    AppValidationMessage.upperRequired: FormMessageConstants.passwordUpperRequired,
                    AppValidationMessage.lowerRequired: FormMessageConstants.passwordLowerRequired,
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
                ReactiveFormConsumer(
                  builder: (formContext, form, child) {
                    return FormProgressButton(
                      text: 'Register',
                      iconData: Icons.how_to_reg,
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
            ),
          ),
        );
      },
    );
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext context,
    FormGroup form,
    EmailVerificationState viewState,
  ) {
    return form.valid
        ? () {
            if (viewState.hasError) {
              context
                  .read<EmailVerificationBloc>()
                  .add(EmailVerificationEventResetError());
            } else if (!viewState.inProgress) {
              context
                  .read<EmailVerificationBloc>()
                  .add(EmailVerificationEventSubmit(
                    signUpUser: SignUpUser(
                      firstName: (form.value['firstName']! as String).trim(),
                      lastName: (form.value['lastName']! as String).trim(),
                      email: (form.value['email']! as String).trim(),
                      password: (form.value['password']! as String).trim(),
                      confirmPassword:
                          (form.value['password']! as String).trim(),
                    ),
                  ));
            }
          }
        : null;
  }
}
