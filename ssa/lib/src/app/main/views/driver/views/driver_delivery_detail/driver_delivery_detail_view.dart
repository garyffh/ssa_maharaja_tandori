import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/main/views/driver/driver_nav_cubit.dart';
import 'package:single_store_app/src/app/models/driver/trn_deliveries_item.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/models/order/trn_order_store_status.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/address/address_widget.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_continue_widget.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/action_button.dart';
import 'package:single_store_app/src/app/widgets/ui/action_button_vertical.dart';
import 'package:single_store_app/src/app/widgets/ui/confirmation_dialog.dart';
import 'package:single_store_app/src/app/widgets/ui/line_description_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_qty_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_total_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/line_unit_cell.dart';
import 'package:single_store_app/src/app/widgets/ui/name_value_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';

import 'driver_delivery_detail_bloc.dart';
import 'driver_delivery_detail_event.dart';
import 'driver_delivery_detail_state.dart';

class DriverDeliveryDetailView extends StatelessWidget {
  const DriverDeliveryDetailView({
    required this.trnOrderId,
    Key? key,
  }) : super(key: key);

  final String trnOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDeliveryDetailBloc(
        driverRepo: context.read<DriverRepo>(),
        driverNavCubit: context.read<DriverNavCubit>(),
        trnOrderMessagingBloc: context.read<TrnOrderMessagingBloc>(),
      )..add(DriverDeliveryDetailEventGetViewModel(trnOrderId: trnOrderId)),
      child: BlocBuilder<DriverDeliveryDetailBloc, DriverDeliveryDetailState>(
          builder: (viewContext, state) {
        return SubView(
          title: 'Delivery',
          child: _view(viewContext, state),
        );
      }),
    );
  }

  Widget _view(BuildContext viewContext, DriverDeliveryDetailState viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as DriverDeliveryDetailStateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<DriverDeliveryDetailBloc>()
                .add(DriverDeliveryDetailEventGetViewModel(
                    trnOrderId: trnOrderId)),
          );
        }

      case ProgressErrorStateType.progressError:
        {
          return ProgressErrorContinueWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.sending,
            continueCallback: () => viewContext
                .read<DriverDeliveryDetailBloc>()
                .add(DriverDeliveryDetailEventGetViewModel(
                    trnOrderId: trnOrderId)),
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
    DriverDeliveryDetailStateViewModel viewModel,
  ) {
    return Container(
      padding: EdgeInsets.all(
          viewContext.watch<MediaSettingsBloc>().state.formPadding),
      child: Column(
        children: [
          _header(viewContext, viewModel),
          if (viewModel.trnDelivery.storeStatus ==
                  TrnOrderStoreStatus.waitingForDelivery ||
              viewModel.trnDelivery.storeStatus ==
                  TrnOrderStoreStatus.delivering)
            _actions(viewContext, viewModel),
          if (viewModel.trnDelivery.storeStatus ==
              TrnOrderStoreStatus.delivering)
            _address(viewContext, viewModel),
          Expanded(
            child: _lines(viewContext, viewModel),
          )
        ],
      ),
    );
  }

  Widget _header(
    BuildContext viewContext,
    DriverDeliveryDetailStateViewModel viewModel,
  ) {
    return Card(
      child: Container(
        padding: viewContext.watch<MediaSettingsBloc>().state.allBoxPadding,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  NameValueWidget(
                    name: 'ORDER',
                    value: viewModel.trnDelivery.reference,
                  ),
                  NameValueWidget(
                    name: 'STATUS',
                    value: viewModel.trnDelivery.storeStatus.text,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(
                  viewContext.watch<MediaSettingsBloc>().state.sp10),
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    '${viewModel.trnDelivery.firstName} ${viewModel.trnDelivery.lastName}',
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.bodyText1,
                  ),
                  if (viewModel.trnDelivery.storeStatus ==
                      TrnOrderStoreStatus.delivering)
                    Text(
                      viewModel.trnDelivery.phoneNumber,
                      style: viewContext
                          .watch<MediaSettingsBloc>()
                          .state
                          .bodyText1,
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(
                  viewContext.watch<MediaSettingsBloc>().state.sp10),
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    viewModel.trnDelivery.deliveryMethodAsap
                        ? 'Delivery ASAP'
                        : 'Delivery',
                    style: viewContext
                        .watch<MediaSettingsBloc>()
                        .state
                        .subtitle2
                        .bold,
                  ),
                  Text(
                    Formats.dayMonthTime(
                        viewModel.trnDelivery.scheduledDeliveryMethodTime),
                    style:
                        viewContext.watch<MediaSettingsBloc>().state.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actions(
    BuildContext viewContext,
    DriverDeliveryDetailStateViewModel viewModel,
  ) {
    return Card(
      child: Container(
        padding: viewContext.watch<MediaSettingsBloc>().state.allBoxPadding,
        width: double.infinity,
        child: Column(
          children: [
            if (viewModel.trnDelivery.storeStatus ==
                TrnOrderStoreStatus.waitingForDelivery)
              ActionButton(
                text: 'Picked Up',
                iconData: Icons.directions_walk,
                onPressed: () => _showPickedUpDriveConfirmationDialog(
                    viewContext, viewModel),
              ),
            if (viewModel.trnDelivery.storeStatus ==
                TrnOrderStoreStatus.delivering)
              Container(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    ActionButtonVertical(
                      text: 'Navigate',
                      iconData: Icons.navigation,
                      onPressed: () =>
                          openNavigationSheet(viewContext, viewModel),
                    ),
                    ActionButtonVertical(
                      text: 'Delivered',
                      iconData: Icons.done_all,
                      onPressed: () => _showDeliveredConfirmationDialog(
                          viewContext, viewModel),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _address(
    BuildContext viewContext,
    DriverDeliveryDetailStateViewModel viewModel,
  ) {
    return Card(
      child: Container(
        padding: viewContext.watch<MediaSettingsBloc>().state.allBoxPadding,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deliver To',
                style: viewContext
                    .watch<MediaSettingsBloc>()
                    .state
                    .subtitle2
                    .bold),
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            AddressWidget(
              addressNote: viewModel.trnDelivery.addressNote,
              street: viewModel.trnDelivery.street,
              extended: viewModel.trnDelivery.extended,
              locality: viewModel.trnDelivery.locality,
              region: viewModel.trnDelivery.region,
              postalCode: viewModel.trnDelivery.postalCode,
              country: viewModel.trnDelivery.country,
              showCountry: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _lines(
    BuildContext viewContext,
    DriverDeliveryDetailStateViewModel viewModel,
  ) {
    final List<TrnDeliveriesItem> readableItems =
        viewModel.trnDelivery.readableItems();

    return Table(
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(viewContext.watch<MediaSettingsBloc>().state.sp30),
        1: const FlexColumnWidth(),
        2: const IntrinsicColumnWidth(),
        3: const IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: List<TableRow>.generate(readableItems.length, (index) {
        final TrnDeliveriesItem item = readableItems[index];
        return TableRow(
          children: <Widget>[
            LineQtyCell(
              show: item.itemTypeId == 3,
              isScale: item.isScale,
              qty: item.qty,
            ),
            LineDescriptionCell(
              isCondiment: item.isCondiment,
              isInstructions: item.isInstructions,
              description: item.description,
            ),
            LineUnitCell(
              isCondiment: item.isCondiment,
              unit: item.unitPrice,
            ),
            LineTotalCell(
              isCondiment: item.isCondiment,
              total: item.total,
            ),
          ],
        );
      }),
    );
  }

  void _showPickedUpDriveConfirmationDialog(
    BuildContext viewContext,
    DriverDeliveryDetailStateViewModel viewModel,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Picked Up',
              content: 'Confirm the order has been picked up.',
              onConfirm: () {
                Navigator.pop(context);
                BlocProvider.of<DriverDeliveryDetailBloc>(viewContext).add(
                  DriverDeliveryDetailEventPickedUp(
                    trnOrderId: trnOrderId,
                  ),
                );
              },
            );
          });

  void _showDeliveredConfirmationDialog(
    BuildContext viewContext,
    DriverDeliveryDetailStateViewModel viewModel,
  ) =>
      showDialog<ConfirmationDialog>(
          context: viewContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              title: 'Delivered',
              content: 'Confirm the order has been delivered.',
              onConfirm: () {
                Navigator.pop(context);
                viewContext.read<DriverDeliveryDetailBloc>().add(
                      DriverDeliveryDetailEventDelivered(
                        trnOrderId: trnOrderId,
                      ),
                    );
              },
            );
          });

  Future<void> openNavigationSheet(
    BuildContext viewContext,
    DriverDeliveryDetailStateViewModel viewModel,
  ) async {
    try {
      if (viewModel.trnDelivery.lat != null &&
          viewModel.trnDelivery.lng != null) {
        final coords =
            Coords(viewModel.trnDelivery.lat!, viewModel.trnDelivery.lng!);
        final String title = viewModel.trnDelivery.street;
        final availableMaps = await MapLauncher.installedMaps;

        await showModalBottomSheet<void>(
          context: viewContext,
          builder: (BuildContext context) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Wrap(
                  children: <Widget>[
                    for (AvailableMap map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showMarker(
                            coords: coords,
                            title: title,
                          );
                          Navigator.pop(context);
                        },
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      // print(e);
    }
  }
}
