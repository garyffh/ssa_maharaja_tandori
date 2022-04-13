import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';

import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class NameValueWidget extends StatelessWidget {
  const NameValueWidget({
    required this.name,
    required this.value,
    this.alignment =  WrapAlignment.start,
    Key? key,
  }) : super(key: key);

  final String name;
  final String value;
  final  WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.watch<MediaSettingsBloc>().state.sp10),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: alignment,
      children: [
        Text(
          name,
          style: context.watch<MediaSettingsBloc>().state.subtitle2.bold,
        ),
        SizedBox( width: context.watch<MediaSettingsBloc>().state.sp10),
        Text(
          value,
          style: context.watch<MediaSettingsBloc>().state.bodyText1,
        ),
      ],
      ),
    );
  }
}
