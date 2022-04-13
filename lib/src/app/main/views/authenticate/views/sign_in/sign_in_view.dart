import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/constants/form_message.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_validators.dart';
import 'package:single_store_app/src/app/infrastructure/validators/app_validation_message.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_event.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_state.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/models/authentication/signed_up_user.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/view/primary_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({
    this.viewMessage,
    this.signedUpUser,
    Key? key,
  }) : super(key: key);

  final List<String>? viewMessage;
  final SignedUpUser? signedUpUser;

  @override
  State<StatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return PrimaryView(
          title: 'Sign In',
          child: _viewModel(context, state),
        );
      },
    );
  }

  Widget _viewModel(BuildContext context, AuthenticationState viewState) {
    return ReactiveFormBuilder(
        form: buildForm,
        builder: (formContext, form, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.viewMessage != null) _viewInitialMessage(context),
              _viewForm(context, viewState),
              _viewButtons(context),
            ],
          );
        });
  }

  Widget _viewForm(BuildContext context, AuthenticationState viewState) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.watch<MediaSettingsBloc>().state.formMaxWidth,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: context.watch<MediaSettingsBloc>().state.formPadding),
      child: ReactiveFormBuilder(
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
                  formControlName: 'email',
                  validationMessages: (control) => {
                    ValidationMessage.required:
                        FormMessageConstants.emailRequired,
                    ValidationMessage.email: FormMessageConstants.emailValid,
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Theme.of(context).iconTheme.color,
                      size: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .formFieldIconSize,
                    ),
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
                    icon: Icon(
                      Icons.security,
                      color: Theme.of(context).iconTheme.color,
                      size: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .formFieldIconSize,
                    ),
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
                      text: 'Sign In',
                      iconData: Icons.login,
                      progressFormView: viewState,
                      onPressed:
                          onPressedSubmitButton(context, form, viewState),
                      dataDirection: DataDirection.none,
                    );
                  },
                ),
                SizedBox(
                    height:
                        context.watch<MediaSettingsBloc>().state.smallPadding),
                FormErrorMessageWidget(
                  errorMessage: viewState.stateErrorMessage(),
                ),
                context.watch<MediaSettingsBloc>().state.padding,
              ],
            );
          }),
    );
  }

  FormGroup buildForm() => widget.signedUpUser == null
      ? fb.group(<String, Object>{
          'email': [
            '',
            Validators.required,
            AppValidators.emailTrim,
          ],
          'password': [
            '',
            ...AppValidators.passwordValidators,
          ],
        })
      : fb.group(<String, Object>{
          'email': [
            widget.signedUpUser!.email,
            Validators.required,
            AppValidators.emailTrim,
          ],
          'password': [
            widget.signedUpUser!.password,
            ...AppValidators.passwordValidators,
          ],
        });

  Widget _viewInitialMessage(BuildContext context) {
    if (widget.viewMessage == null) {
      return Column();
    } else {
      return Container(
        padding: context.watch<MediaSettingsBloc>().state.verticalBoxPadding,
        child: Column(
          children: [
            for (String line in widget.viewMessage!)
              Text(
                line,
                style: context.watch<MediaSettingsBloc>().state.subtitle1,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      );
    }
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext context,
    FormGroup form,
    AuthenticationState viewState,
  ) {
    return form.valid
        ? () {
            if (viewState.hasError) {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationEventResetError());
            } else if (!viewState.inProgress) {
              context.read<AuthenticationBloc>().add(AuthenticationEventSignIn(
                    email: (form.value['email']! as String).trim(),
                    password: (form.value['password']! as String).trim(),
                  ));
            }
          }
        : null;
  }

  Widget _viewButtons(BuildContext context) {
    return Column(
      children: [
        context.watch<MediaSettingsBloc>().state.padding,
        _resetPasswordButton(context),
        SizedBox(height: context.watch<MediaSettingsBloc>().state.formPadding),
        _emailSignUpButton(context),
        context.watch<MediaSettingsBloc>().state.padding,
      ],
    );
  }

  Widget _resetPasswordButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Forgot password.',
        style: TextStyle(
          fontSize: context.watch<MediaSettingsBloc>().state.buttonFontSize,
        ),
      ),
      onPressed: () =>
          context.read<AuthenticateNavCubit>().showPasswordVerification(),
    );
  }

  Widget _emailSignUpButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Register now.',
        style: TextStyle(
          fontSize: context.watch<MediaSettingsBloc>().state.buttonFontSize,
        ),
      ),
      onPressed: () =>
          context.read<AuthenticateNavCubit>().showEmailVerification(),
    );
  }
}
