import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_state.dart';
import 'package:single_store_app/src/app/main/services/store_status_display/store_status_display_bloc.dart';
import 'package:single_store_app/src/app/main/views/home/home_nav_cubit.dart';
import 'package:single_store_app/src/app/main/views/home/order/widgets/banner_image_widget.dart';
import 'package:single_store_app/src/app/models/business/store_status_display.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_state.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class StoreStatusWidget extends StatefulWidget {
  const StoreStatusWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StoreStatusWidgetState();
}

class _StoreStatusWidgetState extends State<StoreStatusWidget> {
  List<bool> isOpenPanels = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreStatusBloc, StoreStatusState>(
        builder: (viewContext, storeStatusState) {
      return AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: _view(viewContext, storeStatusState),
      );
    });
  }

  Widget _view(BuildContext viewContext, StoreStatusState storeStatusState) {
    if (viewContext.watch<StoreStatusDisplayBloc>().state.showBanner) {
      return const BannerImageWidget();
    } else {
      final BusinessSettingsState businessSettingsState =
          viewContext.watch<BusinessSettingsBloc>().state;

      return (storeStatusState is StoreStatusStateLoaded &&
              businessSettingsState is BusinessSettingsStateLoaded)
          ? Card(
              child: _statusView(
                  viewContext, storeStatusState, businessSettingsState),
            )
          : const BannerImageWidget();
    }
  }

  Widget _statusView(
      BuildContext viewContext,
      StoreStatusStateLoaded storeStatusState,
      BusinessSettingsStateLoaded businessSettingsState) {
    if (storeStatusState.storeStatus.storeState.storeAvailable ||
        storeStatusState.storeStatus.storeState.deliveryAvailable ||
        businessSettingsState.useDeliveryPeriods) {
      if (businessSettingsState.useDeliveryPeriods ||
          storeStatusState.storeStatus.storeState.storeOnline &&
              (storeStatusState.storeStatus.storeState.manualStoreOnline ||
                  storeStatusState
                      .storeStatus.storeState.manualDeliveryOnline)) {
        if (storeStatusState.storeStatus.storeState.storeAvailable &&
            (storeStatusState.storeStatus.storeState.deliveryAvailable ||
                businessSettingsState.useDeliveryPeriods)) {
          return _storeAndDelivery(
              viewContext, storeStatusState, businessSettingsState);
        } else {
          return _storeOrDelivery(
              viewContext, storeStatusState, businessSettingsState);
        }
      } else {
        return _offline(viewContext, storeStatusState, businessSettingsState);
      }
    } else {
      return _openingSoon(viewContext, storeStatusState, businessSettingsState);
    }
  }

  Widget _openingSoon(
      BuildContext viewContext,
      StoreStatusStateLoaded storeStatusState,
      BusinessSettingsStateLoaded businessSettingsState) {
    return Container(
      width: double.infinity,
      padding: viewContext.watch<MediaSettingsBloc>().state.allBoxPadding,
      child: Column(
        children: [
          Text(
            'CLOSED',
            style: viewContext.watch<MediaSettingsBloc>().state.subtitle2,
          ),
          viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          Text(
            AppConstants.openingSoonMessage,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _offline(
      BuildContext viewContext,
      StoreStatusStateLoaded storeStatusState,
      BusinessSettingsStateLoaded businessSettingsState) {
    return Container(
      width: double.infinity,
      padding: viewContext.watch<MediaSettingsBloc>().state.allBoxPadding,
      child: Column(
        children: [
          Text(
            'OFFLINE',
            style: viewContext.watch<MediaSettingsBloc>().state.subtitle2,
          ),
          viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingH,
          Text(
            AppConstants.offlineMessage,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _storeAndDelivery(
      BuildContext viewContext,
      StoreStatusStateLoaded storeStatusState,
      BusinessSettingsStateLoaded businessSettingsState) {
    return ExpansionPanelList(
      children: [
        _storeDeliveryMethod(
            viewContext, storeStatusState, businessSettingsState),
        _deliveryDeliveryMethod(
            viewContext, storeStatusState, businessSettingsState),
      ],
      expansionCallback: (index, isOpen) =>
          setState(() => isOpenPanels[index] = !isOpen),
    );
  }

  Widget _storeOrDelivery(
      BuildContext viewContext,
      StoreStatusStateLoaded storeStatusState,
      BusinessSettingsStateLoaded businessSettingsState) {
    if (storeStatusState.storeStatus.storeState.storeAvailable) {
      return ExpansionPanelList(
        children: [
          _storeDeliveryMethod(
              viewContext, storeStatusState, businessSettingsState),
        ],
        expansionCallback: (index, isOpen) =>
            setState(() => isOpenPanels[index] = !isOpen),
      );
    } else {
      return ExpansionPanelList(
        children: [
          _deliveryDeliveryMethod(
              viewContext, storeStatusState, businessSettingsState),
        ],
        expansionCallback: (index, isOpen) =>
            setState(() => isOpenPanels[index] = !isOpen),
      );
    }
  }

  ExpansionPanel _storeDeliveryMethod(
      BuildContext viewContext,
      StoreStatusStateLoaded storeStatusState,
      BusinessSettingsStateLoaded businessSettingsState) {
    final StoreStatusDisplay storeStatusDisplay =
        storeStatusState.storeStatus.storeTimesDisplay(
      useDeliveryZones: businessSettingsState.usesDeliveryZones,
      deliveryFee: businessSettingsState.deliveryFee,
      minOrder: businessSettingsState.minOrder,
    );

    return ExpansionPanel(
      headerBuilder: (viewContext, isOpen) {
        return Row(
          children: [
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingW,
            Icon(
              Icons.event,
              size: viewContext.watch<MediaSettingsBloc>().state.sp22,
            ),
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingW,
            Expanded(
              child: Text(
                storeStatusDisplay.title,
                style: viewContext.watch<MediaSettingsBloc>().state.subtitle2,
              ),
            ),
          ],
        );
      },
      body: _bodyWidget(viewContext, storeStatusDisplay, false),
      isExpanded: isOpenPanels[0],
    );
  }

  ExpansionPanel _deliveryDeliveryMethod(
      BuildContext viewContext,
      StoreStatusStateLoaded storeStatusState,
      BusinessSettingsStateLoaded businessSettingsState) {
    final StoreStatusDisplay storeStatusDisplay =
        storeStatusState.storeStatus.deliveryTimesDisplay(
      useDeliveryZones: businessSettingsState.usesDeliveryZones,
      deliveryFee: businessSettingsState.deliveryFee,
      minOrder: businessSettingsState.minOrder,
      useDeliveryPeriods: businessSettingsState.useDeliveryPeriods,
    );

    return ExpansionPanel(
      headerBuilder: (viewContext, isOpen) {
        return Row(
          children: [
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingW,
            Icon(
              Icons.local_shipping,
              size: viewContext.watch<MediaSettingsBloc>().state.sp22,
            ),
            viewContext.watch<MediaSettingsBloc>().state.formFieldPaddingW,
            Expanded(
              child: Text(
                storeStatusDisplay.title,
                style: viewContext.watch<MediaSettingsBloc>().state.subtitle2,
              ),
            ),
          ],
        );
      },
      body: _bodyWidget(viewContext, storeStatusDisplay, true),
      isExpanded: isOpenPanels[1],
    );
  }

  Widget _bodyWidget(
    BuildContext viewContext,
    StoreStatusDisplay storeStatusDisplay,
    bool showDeliveryAreas,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.only(top: 0, left: 8.0, right: 8.0, bottom: 8.0),
      child: _bodyText(viewContext, storeStatusDisplay, showDeliveryAreas),
    );
  }

  Widget _bodyText(
    BuildContext viewContext,
    StoreStatusDisplay storeStatusDisplay,
    bool showDeliveryAreas,
  ) {
    if (storeStatusDisplay.bodyLine3 != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            storeStatusDisplay.bodyLine1,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          ),
          Text(
            storeStatusDisplay.bodyLine2!,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          ),
          Text(
            storeStatusDisplay.bodyLine3!,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          ),
          if (showDeliveryAreas) _deliveryAreaButton(viewContext),
        ],
      );
    } else if (storeStatusDisplay.bodyLine2 != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            storeStatusDisplay.bodyLine1,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          ),
          Text(
            storeStatusDisplay.bodyLine2!,
            style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
          ),
          if (showDeliveryAreas) _deliveryAreaButton(viewContext),
        ],
      );
    } else {
      if (showDeliveryAreas) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storeStatusDisplay.bodyLine1,
              style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
            ),
            _deliveryAreaButton(viewContext),
          ],
        );
      } else {
        return Text(
          storeStatusDisplay.bodyLine1,
          style: viewContext.watch<MediaSettingsBloc>().state.bodyText1,
        );
      }
    }
  }

  Widget _deliveryAreaButton(BuildContext viewContext) {
    return SizedBox(
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton.icon(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                Theme.of(viewContext).titleColor),
          ),
          label: Text(
            'Delivery Areas',
            style:
            viewContext.watch<MediaSettingsBloc>().state.titleActionTextStyle,
          ),
          icon: Icon(
            Icons.place,
            size: viewContext.watch<MediaSettingsBloc>().state.titleActionIconSize,
          ),
          onPressed: () => viewContext.read<HomeNavCubit>().showDeliveryAreas(),
        ),
      ]),
    );
  }
}
