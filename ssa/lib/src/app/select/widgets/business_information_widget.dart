import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/multi_store/store_settings.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class BusinessInformationWidget extends StatelessWidget {
  const BusinessInformationWidget({
    required this.storeSettings,
    required this.fullWidth,
    Key? key,
  }) : super(key: key);

  final StoreSettings storeSettings;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : 250,
      padding: EdgeInsets.only(left: context.watch<MediaSettingsBloc>().state.sp18),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          storeSettings.businessName,
          style: context.watch<MediaSettingsBloc>().state.subtitle2,
          textAlign: TextAlign.start,
        ),
        context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
        Text(
          storeSettings.street,
          style: context.watch<MediaSettingsBloc>().state.bodyText2,
          textAlign: TextAlign.start,
        ),
        Text(
          '${storeSettings.locality} ${storeSettings.region}',
          style: context.watch<MediaSettingsBloc>().state.bodyText2,
          textAlign: TextAlign.start,
        ),
      ],
      ),
    );
  }
}
