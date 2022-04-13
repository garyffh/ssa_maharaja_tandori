import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:single_store_app/src/app/constants/quill_css.constants.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/error_dialog.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_loading_error_widget.dart';
import 'package:single_store_app/src/app/widgets/form/form_progress_button_small.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'driver_enable_deliveries_bloc.dart';
import 'driver_enable_deliveries_event.dart';
import 'driver_enable_deliveries_state.dart';

class DriverEnableDeliveriesView extends StatefulWidget {
  const DriverEnableDeliveriesView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DriverEnableDeliveriesViewState();
}

class _DriverEnableDeliveriesViewState
    extends State<DriverEnableDeliveriesView> {
  final FormGroup form = fb.group(<String, Object>{
    'acceptAgreement': [
      false,
      Validators.required,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverEnableDeliveriesBloc(
        driverRepo: context.read<DriverRepo>(),
        driverNavCubit: context.read<DriverNavCubit>(),
      )..add(DriverEnableDeliveriesEventGetViewModel()),
      child:
          BlocConsumer<DriverEnableDeliveriesBloc, DriverEnableDeliveriesState>(
        listener: (viewContext, state) {
          if (state.hasError &&
              state.type == ProgressErrorStateType.progressError) {
            _showErrorMessageDialog(
              viewContext: viewContext,
              errorMessage: state.stateErrorMessage()!,
            );
          }
        },
        builder: (viewContext, state) {
          return SubView(
            title: 'Enable Deliveries',
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(
    BuildContext viewContext,
    DriverEnableDeliveriesState viewState,
  ) {
    switch (viewState.type) {
      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return FormLoadingErrorWidget(
            progressFormView: viewState,
            tryAgainCallback: () =>
                viewContext.read<DriverEnableDeliveriesBloc>().add(
                      DriverEnableDeliveriesEventGetViewModel(),
                    ),
          );
        }

      case ProgressErrorStateType.progressError:
      case ProgressErrorStateType.submitted:
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as DriverEnableDeliveriesStateViewModel);
        }

      case ProgressErrorStateType.idle:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    DriverEnableDeliveriesStateViewModel viewState,
  ) {
    return Column(
      children: [
        _viewForm(
          viewContext,
          viewState,
        ),
        Expanded(
          child: _viewAgreement(
            viewContext,
            viewState,
          ),
        ),
      ],
    );
  }

  Widget _viewForm(
    BuildContext viewContext,
    DriverEnableDeliveriesStateViewModel viewState,
  ) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: viewContext.watch<MediaSettingsBloc>().state.formMaxWidth,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: viewContext.watch<MediaSettingsBloc>().state.formPadding),
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            viewContext.watch<MediaSettingsBloc>().state.padding,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox.shrink()),
                Transform.scale(
                  scale: viewContext.watch<MediaSettingsBloc>().state.sp(4),
                  child: ReactiveCheckbox(
                    formControlName: 'acceptAgreement',
                  ),
                ),
                // viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingW,
                Text(
                  'I accept the Driver Agreement',
                  style: viewContext.watch<MediaSettingsBloc>().state.bodyText2,
                ),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'My Vehicle: ${viewState.driverEnableDeliveries.make} ${viewState.driverEnableDeliveries.model} ${viewState.driverEnableDeliveries.plate} ${viewState.driverEnableDeliveries.colour}',
                  style: viewContext.watch<MediaSettingsBloc>().state.bodyText2,
                ),
              ],
            ),
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            ReactiveFormConsumer(
              builder: (formContext, form, child) {
                return FormProgressButtonSmall(
                  text: 'Enable Deliveries',
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
            viewContext.watch<MediaSettingsBloc>().state.padding,
          ],
        ),
      ),
    );
  }

  VoidCallback? onPressedSubmitButton(
    BuildContext viewContext,
    FormGroup form,
    DriverEnableDeliveriesState viewState,
  ) {
    return form.valid && form.value['acceptAgreement']! as bool
        ? () {
            if (viewState.hasError) {
              viewContext.read<DriverNavCubit>().showDeliveries();
            } else if (!viewState.inProgress) {
              viewContext.read<DriverEnableDeliveriesBloc>().add(
                    DriverEnableDeliveriesEventSubmit(),
                  );
            }
          }
        : null;
  }

  Widget _viewAgreement(
    BuildContext viewContext,
    DriverEnableDeliveriesStateViewModel viewState,
  ) {
    return kIsWeb
        ? const Text('PLACEHOLDER')
        : WebView(
            initialUrl: 'about:blank',
            onWebViewCreated: (WebViewController webViewController) {
              webViewController.loadUrl(
                Uri.dataFromString(
                        quillCss + viewState.driverEnableDeliveries.conditions,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString(),
              );
            },
          );
  }

  void _showErrorMessageDialog({
    required BuildContext viewContext,
    required List<String> errorMessage,
  }) =>
      showDialog<ErrorDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ErrorDialog(
              errorMessage: errorMessage,
              onContinue: () {
                Navigator.pop(context);
                viewContext.read<DriverEnableDeliveriesBloc>().add(
                      DriverEnableDeliveriesEventResetError(),
                    );
              },
            );
          });
}
