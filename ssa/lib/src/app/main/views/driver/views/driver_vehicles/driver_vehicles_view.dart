import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/models/driver/driver_vehicle.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/confirmation_dialog.dart';
import 'package:single_store_app/src/app/widgets/ui/empty_list_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/title_action_button.dart';
import 'package:single_store_app/src/app/widgets/view/view_title_widget.dart';

import 'driver_vehicles_bloc.dart';
import 'driver_vehicles_event.dart';
import 'driver_vehicles_state.dart';

class DriverVehiclesView extends StatelessWidget {
  const DriverVehiclesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverVehiclesBloc(
        driverRepo: RepositoryProvider.of<DriverRepo>(context),
      )..add(DriverVehiclesEventGetViewModel()),
      child: BlocBuilder<DriverVehiclesBloc, DriverVehiclesState>(
        builder: (viewContext, state) {
          return Column(
            children: [
              ViewTitleWidget(
                title: 'Vehicles',
                trailingWidget: state.type == ProgressErrorStateType.loaded
                    ? TitleActionButton(
                        onPressed: () =>
                            viewContext.read<DriverNavCubit>().showVehicleAdd(),
                      )
                    : null,
              ),
              Expanded(
                child: _view(viewContext, state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, DriverVehiclesState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as DriverVehiclesStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<DriverVehiclesBloc>()
                .add(DriverVehiclesEventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            tryAgainCallback: () =>
                BlocProvider.of<DriverVehiclesBloc>(viewContext)
                    .add(DriverVehiclesEventGetViewModel()),
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
    DriverVehiclesStateViewModel viewModel,
  ) {
    return viewModel.driverVehicles.isEmpty
        ? const EmptyListWidget(label: 'No Vehicles')
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: viewModel.driverVehicles.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(
                    context.watch<MediaSettingsBloc>().state.sp16,
                  ),
                  selected: viewModel.driverVehicles[index].currentCar,
                  selectedTileColor: Theme.of(context).canvasColor,
                  title: Text(
                    '${viewModel.driverVehicles[index].make} ${viewModel.driverVehicles[index].model}',
                    style: context.watch<MediaSettingsBloc>().state.subtitle1,
                  ),
                  subtitle: viewModel.driverVehicles[index].currentCar
                      ? Text(
                          '${viewModel.driverVehicles[index].colour}; ${viewModel.driverVehicles[index].plate}; Current.',
                          style: context
                              .watch<MediaSettingsBloc>()
                              .state
                              .bodyText1)
                      : Text(
                          '${viewModel.driverVehicles[index].colour}; ${viewModel.driverVehicles[index].plate}.',
                          style: context
                              .watch<MediaSettingsBloc>()
                              .state
                              .bodyText1,
                        ),
                  trailing:
                      _popupMenu(viewContext, viewModel.driverVehicles[index]),
                ),
              );
            },
          );
  }

  Widget _popupMenu(
    BuildContext viewContext,
    DriverVehicle driverVehicle,
  ) =>
      PopupMenuButton<int>(
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: 1,
            child: Text('Make Current'),
          ),
          PopupMenuItem(
            value: 2,
            child: Text('Remove'),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case 1:
              _showSetDefaultConfirmationDialog(viewContext, driverVehicle);
              break;

            case 2:
              _showRemoveConfirmationDialog(viewContext, driverVehicle);
              break;
          }
        },
      );

  void _showSetDefaultConfirmationDialog(
    BuildContext viewContext,
    DriverVehicle driverVehicle,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Current Vehicle',
              content: 'Confirm setting to the current vehicle.',
              onConfirm: () {
                Navigator.pop(context);
                BlocProvider.of<DriverVehiclesBloc>(viewContext).add(
                  DriverVehiclesEventSetDefault(
                    driverVehicle: driverVehicle,
                  ),
                );
              },
            );
          });

  void _showRemoveConfirmationDialog(
    BuildContext viewContext,
    DriverVehicle driverVehicle,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Remove Vehicle',
              content: 'Confirm removing the vehicle.',
              onConfirm: () {
                Navigator.pop(context);
                viewContext.read<DriverVehiclesBloc>().add(
                      DriverVehiclesEventDelete(
                        driverVehicle: driverVehicle,
                      ),
                    );
              },
            );
          });
}
