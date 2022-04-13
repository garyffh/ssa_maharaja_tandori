import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/main/services/address/address_bloc.dart';
import 'package:single_store_app/src/app/main/services/address/address_event.dart';
import 'package:single_store_app/src/app/main/services/address/address_state.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/user/user_address.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/address/address_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';

class AddressNoteWidget extends StatefulWidget {
  const AddressNoteWidget({
    this.onSubmitAddress,
    required this.saveAddress,
    required this.showCompany,
    Key? key,
  }) : super(key: key);

  final void Function(UserAddress address)? onSubmitAddress;
  final bool saveAddress;
  final bool showCompany;

  @override
  State<AddressNoteWidget> createState() => _AddressNoteWidgetState();
}

class _AddressNoteWidgetState extends State<AddressNoteWidget> {
  final FormGroup form = FormGroup({
    'company': FormControl<String?>(
      value: null,
      validators: [
        Validators.maxLength(80),
      ],
    ),
    'companyNumber': FormControl<String?>(
      value: null,
      validators: [
        Validators.maxLength(80),
      ],
    ),
    'addressNote': FormControl<String?>(
      value: null,
      validators: [
        Validators.maxLength(80),
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
        builder: (viewContext, viewState) {
      return _view(viewContext, viewState);
    });
  }

  Widget _view(BuildContext viewContext, AddressState viewState) {
    switch (viewState.type) {
      case AddressProgressStateType.initial:
      case AddressProgressStateType.queryCommenced:
      case AddressProgressStateType.result:
      case AddressProgressStateType.progressError:
      case AddressProgressStateType.submitted:
        {
          return const UnhandledStateWidget();
        }

      case AddressProgressStateType.validated:
      case AddressProgressStateType.submitProgress:
        {
          return _viewForm(viewContext, viewState as AddressStateSelected);
        }
    }
  }

  Widget _viewForm(BuildContext viewContext, AddressStateSelected viewModel) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          viewContext.watch<MediaSettingsBloc>().state.padding,
          if (widget.showCompany)
            ReactiveTextField<String?>(
              style: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formFieldTextStyle,
              readOnly: viewModel.formIsReadOnly,
              formControlName: 'company',
              validationMessages: (control) => {
                ValidationMessage.maxLength: 'Maximum of 80 characters',
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                helperText: 'Company (optional)',
                helperStyle: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formHelperTextStyle,
                errorStyle: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formErrorTextStyle,
              ),
            ),
          if (widget.showCompany)
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          if (widget.showCompany)
            ReactiveTextField<String?>(
              style: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formFieldTextStyle,
              readOnly: viewModel.formIsReadOnly,
              formControlName: 'companyNumber',
              validationMessages: (control) => {
                ValidationMessage.maxLength: 'Maximum of 80 characters',
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                helperText: 'Company number (optional)',
                helperStyle: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formHelperTextStyle,
                errorStyle: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .formErrorTextStyle,
              ),
            ),
          if (widget.showCompany)
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          ReactiveTextField<String?>(
            style:
                viewContext.watch<MediaSettingsBloc>().state.formFieldTextStyle,
            readOnly: viewModel.formIsReadOnly,
            formControlName: 'addressNote',
            validationMessages: (control) => {
              ValidationMessage.maxLength: 'Maximum of 80 characters',
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'E.g. ring the bell at the gate.',
              labelStyle: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formLabelTextStyle,
              helperText: 'Address note (optional)',
              helperStyle: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formHelperTextStyle,
              errorStyle: viewContext
                  .watch<MediaSettingsBloc>()
                  .state
                  .formErrorTextStyle,
            ),
          ),
          viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          Container(
            padding: EdgeInsets.only(
              left: viewContext.watch<MediaSettingsBloc>().state.formPadding,
            ),
            child: AddressWidget(
              addressNote: null,
              street: viewModel.address.street,
              extended: viewModel.address.extended,
              locality: viewModel.address.locality,
              region: viewModel.address.region,
              postalCode: viewModel.address.postalCode,
              country: viewModel.address.country,
            ),
          ),
          viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          _submitButton(viewContext, viewModel),
          viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          SizedBox(
              height: context.watch<MediaSettingsBloc>().state.smallPadding),
          FormErrorMessageWidget(
            errorMessage: viewModel.stateErrorMessage(),
          ),
          context.watch<MediaSettingsBloc>().state.padding,
        ],
      ),
    );
  }

  Widget _submitButton(
      BuildContext viewContext, AddressStateSelected viewModel) {

    return ReactiveFormConsumer(
      builder: (formContext, form, child) {
        return SizedBox(
          width: double.infinity,
          child: Center(
            child: FormProgressButton(
              text: 'Save Address',
              progressFormView: viewModel,
              onPressed: onPressedSubmitButton(
                viewContext,
                form,
                viewModel,
              ),
              dataDirection: DataDirection.none,
            ),
          ),
        );
      },
    );
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext context,
    FormGroup form,
    AddressStateSelected viewModel,
  ) {
    return form.valid
        ? () {
            if (viewModel.hasError) {
              context.read<AddressBloc>().add(AddressEventResetError());
            } else if (!viewModel.inProgress) {
              context.read<AddressBloc>().add(AddressEventSubmit(
                    address: UserAddress.fromAddressResult(
                      company: form.value['company'] as String?,
                      companyNumber: form.value['companyNumber'] as String?,
                      addressNote: form.value['addressNote'] as String?,
                      addressResult: viewModel.address,
                    ),
                    saveAddress: widget.saveAddress,
                  ));
            }
          }
        : null;
  }
}
