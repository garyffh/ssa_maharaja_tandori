import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/app.constants.dart';
import 'package:single_store_app/src/app/models/business/store_status_display.dart';
import 'package:single_store_app/src/app/models/multi_store/store_settings.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class SelectStatusWidget extends StatelessWidget {
  const SelectStatusWidget({
    required this.storeSettings,
    Key? key,
  }) : super(key: key);

  final StoreSettings storeSettings;

  @override
  Widget build(BuildContext context) {
    return _statusView(context);
  }

  Widget _statusView(
    BuildContext viewContext,
  ) {

    if (storeSettings.storeStatus.storeState.storeAvailable ||
        storeSettings.storeStatus.storeState.deliveryAvailable ||
        storeSettings.useDeliveryPeriods) {
      if (storeSettings.useDeliveryPeriods ||
          storeSettings.storeStatus.storeState.storeOnline &&
              (storeSettings.storeStatus.storeState.manualStoreOnline ||
                  storeSettings.storeStatus.storeState.manualDeliveryOnline)) {
        if (storeSettings.storeStatus.storeState.storeAvailable &&
            (storeSettings.storeStatus.storeState.deliveryAvailable ||
                storeSettings.useDeliveryPeriods)) {
          return _storeAndDelivery(viewContext);
        } else {
          return _storeOrDelivery(viewContext);
        }
      } else {
        return _offline(viewContext);
      }
    } else {
      return _openingSoon(viewContext);
    }
  }

  Widget _openingSoon(BuildContext viewContext) {
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

  Widget _offline(BuildContext viewContext) {
    return  Container(
          // width: double.infinity,
          decoration:
              BoxDecoration( color: Theme.of(viewContext).dividerColor, border: Border.all(color: Colors.white)),
          constraints: const BoxConstraints(maxWidth: 300),
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
                style: viewContext.watch<MediaSettingsBloc>().state.bodyText2,
                textAlign: TextAlign.center,
              ),
            ],


          ),
    );
  }

  Widget _storeAndDelivery(BuildContext viewContext) {
    return viewContext.watch<MediaSettingsBloc>().state.gtMd
        ? Row(
            children: [
              Flexible(
                child: _storeDeliveryMethod(viewContext),
              ),
              Flexible(
                child: _deliveryDeliveryMethod(viewContext),
              ),
            ],
          )
        : Column(
            children: [
              _storeDeliveryMethod(viewContext),
              _deliveryDeliveryMethod(viewContext),
            ],
          );
  }

  Widget _storeOrDelivery(BuildContext viewContext) {
    if (storeSettings.storeStatus.storeState.storeAvailable) {
      return Column(
        children: [
          _storeDeliveryMethod(viewContext),
        ],
      );
    } else {
      return Column(
        children: [
          _deliveryDeliveryMethod(viewContext),
        ],
      );
    }
  }

  Row _storeDeliveryMethod(BuildContext viewContext) {
    final StoreStatusDisplay storeStatusDisplay =
        storeSettings.storeStatus.storeTimesDisplay(
      useDeliveryZones: storeSettings.usesDeliveryZones,
      deliveryFee: storeSettings.deliveryFee,
      minOrder: storeSettings.minOrder,
    );

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
  }

  Row _deliveryDeliveryMethod(
    BuildContext viewContext,
  ) {
    final StoreStatusDisplay storeStatusDisplay =
        storeSettings.storeStatus.deliveryTimesDisplay(
      useDeliveryZones: storeSettings.usesDeliveryZones,
      deliveryFee: storeSettings.deliveryFee,
      minOrder: storeSettings.minOrder,
      useDeliveryPeriods: storeSettings.useDeliveryPeriods,
    );

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
  }
}
