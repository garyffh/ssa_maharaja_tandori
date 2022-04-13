import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/multi_store/store_settings.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class SelectStatusMessageWidget extends StatelessWidget {
  const SelectStatusMessageWidget({
    required this.storeSettings,
    Key? key,
  }) : super(key: key);

  final StoreSettings storeSettings;

  @override
  Widget build(BuildContext context) {

    return Column(
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
    );
  }
}
