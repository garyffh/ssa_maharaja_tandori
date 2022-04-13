import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/business/delivery_method_times.dart';
import 'package:single_store_app/src/app/models/multi_store/store_settings.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class SelectDeliveryMethodWidget extends StatelessWidget {
  const SelectDeliveryMethodWidget({
    required this.storeSettings,
    required this.deliveryMethod,
    Key? key,
  }) : super(key: key);

  final StoreSettings storeSettings;
  final DeliveryMethodTimes deliveryMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: const BoxConstraints( minWidth: 350),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
    child:
      Row(
      children: [
        const Icon(Icons.sentiment_very_satisfied),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storeSettings.storeStatus.storeState.messageTitle,
              style: context.watch<MediaSettingsBloc>().state.caption,
              textAlign: TextAlign.start,
            ),
            Text(
              storeSettings.storeStatus.storeState.message,
              style: context.watch<MediaSettingsBloc>().state.caption,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
      ),
    );
  }
}
