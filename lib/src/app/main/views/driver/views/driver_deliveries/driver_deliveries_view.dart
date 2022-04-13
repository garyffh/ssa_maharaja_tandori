import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_continue_widget.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/action_button.dart';
import 'package:single_store_app/src/app/widgets/ui/confirmation_dialog.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_list_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_widget.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

import 'driver_deliveries_bloc.dart';
import 'driver_deliveries_event.dart';
import 'driver_deliveries_state.dart';

class DriverDeliveriesView extends StatelessWidget {
  const DriverDeliveriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDeliveriesBloc(
        driverRepo: RepositoryProvider.of<DriverRepo>(context),
        appMessagingCubit: BlocProvider.of<AppMessagingCubit>(context),
        trnOrderMessagingBloc: BlocProvider.of<TrnOrderMessagingBloc>(context),
      )..add(DriverDeliveriesEventGetViewModel()),
      child: BlocBuilder<DriverDeliveriesBloc, DriverDeliveriesState>(
          builder: (viewContext, state) {
        return Column(
          children: [
            const ViewTitleWidget(
              title: 'Deliveries',
            ),
            Expanded(
              child: _view(viewContext, state),
            ),
          ],
        );
      }),
    );
  }

  Widget _view(BuildContext viewContext, DriverDeliveriesState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as DriverDeliveriesStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<DriverDeliveriesBloc>()
                .add(DriverDeliveriesEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          return ProgressErrorContinueWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            continueCallback: () => viewContext
                .read<DriverDeliveriesBloc>()
                .add(DriverDeliveriesEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
    BuildContext viewContext,
    DriverDeliveriesStateViewModel viewModel,
  ) {
    return Column(
      children: [
        _status(viewContext, viewModel),
        Expanded(
          child: _deliveries(viewContext, viewModel),
        )
      ],
    );
  }

  Widget _status(
    BuildContext viewContext,
    DriverDeliveriesStateViewModel viewModel,
  ) {
    return Card(
      child: Container(
        padding: viewContext.watch<MediaSettingsBloc>().state.allBoxPadding,
        width: double.infinity,
        child: viewModel.driverDeliveries.available
            ? Column(
                children: [
                  const NameValueWidget(
                    name: 'STATUS:',
                    value: 'Available',
                  ),
                  viewContext.watch<MediaSettingsBloc>().state.padding,
                  ActionButton(
                    text: 'Make me',
                    text2: 'NOT available',
                    iconData: Icons.person_off,
                    onPressed: () => _showDisableDeliveriesDialog(viewContext),
                  ),
                ],
              )
            : Column(
                children: [
                  const NameValueWidget(
                    name: 'STATUS:',
                    value: 'Not Available',
                  ),
                  viewContext.watch<MediaSettingsBloc>().state.padding,
                  ActionButton(
                    text: "LEFT'S GO!",
                    text2: 'Make me available.',
                    iconData: Icons.notifications_active,
                    onPressed: () => viewContext
                        .read<DriverNavCubit>()
                        .showEnableDeliveries(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _deliveries(
    BuildContext viewContext,
    DriverDeliveriesStateViewModel viewModel,
  ) {
    return viewModel.driverDeliveries.deliveries.isEmpty
        ? const EmptyListWidget(label: 'No Current Deliveries')
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: viewModel.driverDeliveries.deliveries.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    Formats.dayMonthTime(viewModel
                        .driverDeliveries.deliveries[index].scheduledStoreTime),
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.headline6,
                  ),
                  subtitle: Text(
                    '${viewModel.driverDeliveries.deliveries[index].reference} -> ${viewModel.driverDeliveries.deliveries[index].storeStatus.text}',
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.subtitle1,
                  ),
                  trailing: IconButton(
                    iconSize: viewContext.watch<MediaSettingsBloc>().state.sp20,
                    icon: Icon(
                      Icons.navigate_next,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      viewContext.read<DriverNavCubit>().showDeliveryDetail(
                            viewModel
                                .driverDeliveries.deliveries[index].trnOrderId,
                          );
                    },
                  ),
                ),
              );
            },
          );
  }

  void _showDisableDeliveriesDialog(
    BuildContext viewContext,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Disable Deliveries',
              content: 'My deliveries will end in 15 minutes.',
              onConfirm: () {
                Navigator.pop(context);
                viewContext.read<DriverDeliveriesBloc>().add(
                      DriverDeliveriesEventDisableDeliveries(),
                    );
              },
            );
          });
}
