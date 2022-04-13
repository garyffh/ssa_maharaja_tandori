import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/view/primary_view.dart';
import 'package:reactive_forms/reactive_forms.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}View extends StatelessWidget {
  const {{#pascalCase}}{{name}}{{/pascalCase}}View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{#pascalCase}}{{name}}{{/pascalCase}}Bloc(),
      child: PrimaryView(
        title: 'Reset Password',
        child: _viewModel(context),
      ),
    );
  }

  Widget _viewModel(BuildContext context) {
    return BlocBuilder<{{#pascalCase}}{{name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
        builder: (context, viewState) {
      return ReactiveFormBuilder(
          form: buildForm,
          builder: (formContext, form, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _viewForm(context, viewState),
              ],
            );
          });
    });
  }

  Widget _viewForm(BuildContext context, {{#pascalCase}}{{name}}{{/pascalCase}}State viewState) {
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
                    ValidationMessage.required: 'The email address is required',
                    ValidationMessage.email:
                        'The email address is not a valid email',
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
          Validators.email,
        ],
      });

  VoidCallback? onPressedSubmitButton(
    BuildContext context,
    FormGroup form,
{{#pascalCase}}{{name}}{{/pascalCase}}State viewState,
  ) {
    return form.valid
        ? () {
            if (viewState.hasError) {
              form.reset();
              context
                  .read<{{#pascalCase}}{{name}}{{/pascalCase}}Bloc>()
                  .add({{#pascalCase}}{{name}}{{/pascalCase}}EventResetError());
            } else if (!viewState.inProgress) {
              context.read<{{#pascalCase}}{{name}}{{/pascalCase}}Bloc>().add(
{{#pascalCase}}{{name}}{{/pascalCase}}EventSubmit(
                      email: form.value['email']! as String,
                    ),
                  );
            }
          }
        : null;
  }
}
