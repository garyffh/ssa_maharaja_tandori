import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/constants/form_message.constants.dart';
import 'package:single_store_app/src/app/infrastructure/app_validators.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/views/authenticate/authenticate_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_verification/password_verification_bloc.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_verification/password_verification_event.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/password_verification/password_verification_state.dart';
import 'package:single_store_app/src/app/main/views/authenticate/views/widgets/sign_in_button.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/view/primary_view.dart';

class PasswordVerificationView extends StatelessWidget {
  const PasswordVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordVerificationBloc(
        authenticationRepo: context.read<AuthenticationRepo>(),
        authenticateNavCubit: context.read<AuthenticateNavCubit>(),
      ),
      child: PrimaryView(
        title: 'Reset Password',
        child: _viewModel(context),
      ),
    );
  }

  Widget _viewModel(BuildContext context) {
    return BlocBuilder<PasswordVerificationBloc, PasswordVerificationState>(
        builder: (context, viewState) {
      return ReactiveFormBuilder(
          form: buildForm,
          builder: (formContext, form, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _message(context),
                _viewForm(context, viewState),
                const SignInButton(),
              ],
            );
          });
    });
  }

  Widget _message(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.watch<MediaSettingsBloc>().state.subTitleTextMaxWidth,
      ),
      child: Text(
        'Enter your email address to reset your password.',
        style: context.watch<MediaSettingsBloc>().state.subtitle1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _viewForm(BuildContext context, PasswordVerificationState viewState) {
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
                  style:  context.watch<MediaSettingsBloc>().state.formFieldTextStyle,
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
                    helperStyle: context.watch<MediaSettingsBloc>().state.formHelperTextStyle,
                    errorStyle: context.watch<MediaSettingsBloc>().state.formErrorTextStyle,
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
                    // return signInButton(form, viewState);
                  },
                ),
                context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
                FormErrorMessageWidget(
                  errorMessage: viewState.stateErrorMessage(),
                ),
                context.watch<MediaSettingsBloc>().state.padding,
              ],
            );
          }),
    );
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'email': [
          '',
          Validators.required,
          AppValidators.emailTrim,
        ],
      });

  VoidCallback? onPressedSubmitButton(
    BuildContext context,
    FormGroup form,
    PasswordVerificationState viewState,
  ) {
    return form.valid
        ? () {
            if (viewState.hasError) {
              form.reset();
              context
                  .read<PasswordVerificationBloc>()
                  .add(PasswordVerificationEventResetError());
            } else if (!viewState.inProgress) {
              context.read<PasswordVerificationBloc>().add(
                    PasswordVerificationEventSubmit(
                      email: (form.value['email']! as String).trim(),
                    ),
                  );
            }
          }
        : null;
  }

}
