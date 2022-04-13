import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/driver/views/driver_vehicle_add/driver_vehicle_add_state.dart';
import 'package:single_store_app/src/app/models/driver/driver_vehicle.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

import 'driver_vehicle_add_bloc.dart';
import 'driver_vehicle_add_event.dart';

class DriverVehicleAddView extends StatelessWidget {
  const DriverVehicleAddView({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group(<String, Object>{
        'plate': [
          '',
          Validators.required,
        ],
        'model': [
          '',
          Validators.required,
        ],
        'make': [
          '',
          Validators.required,
        ],
        'colour': [
          '',
          Validators.required,
        ],
      });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverVehicleAddBloc(
        driverRepo: context.read<DriverRepo>(),
        driverNavCubit: context.read<DriverNavCubit>(),
      ),
      child: SubView(
        title: 'Add Vehicle',
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
      ],
    );
  }

  Widget _viewForm(BuildContext context) {
    return BlocBuilder<DriverVehicleAddBloc, DriverVehicleAddState>(
      builder: (context, viewState) {
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
                  context.watch<MediaSettingsBloc>().state.padding,
                  ReactiveTextField<String>(
                    style: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .formFieldTextStyle,
                    readOnly: viewState.formIsReadOnly,
                    formControlName: 'plate',
                    validationMessages: (control) => {
                      ValidationMessage.required:
                          'The number plate is required',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Number Plate',
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
                    formControlName: 'make',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'The make is required',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Make',
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
                    formControlName: 'model',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'The model is required',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Model',
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
                    formControlName: 'colour',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'The colour is required',
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Colour',
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
            },
          ),
        );
      },
    );
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext context,
    FormGroup form,
    DriverVehicleAddState viewState,
  ) {
    return form.valid
        ? () {
            if (viewState.hasError) {
              context
                  .read<DriverVehicleAddBloc>()
                  .add(DriverVehicleAddEventResetError());
            } else if (!viewState.inProgress) {
              context
                  .read<DriverVehicleAddBloc>()
                  .add(DriverVehicleAddEventSubmit(
                    driverVehicle: DriverVehicle(
                      updateId: Uint8List(0),
                      userCarId: '',
                      plate: form.value['plate']! as String,
                      model: form.value['model']! as String,
                      make: form.value['make']! as String,
                      colour: form.value['colour']! as String,
                      currentCar: true,
                    ),
                  ));
            }
          }
        : null;
  }
}
