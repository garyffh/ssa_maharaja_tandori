import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';

import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class NameValueLine extends StatelessWidget {
  const NameValueLine({
    required this.name,
    required this.value,
    this.isCurrency = true,
    this.alignment = WrapAlignment.start,
    this.showLine = false,
    this.highlight = false,
    Key? key,
  }) : super(key: key);

  final String name;
  final double value;
  final bool isCurrency;
  final WrapAlignment alignment;
  final bool showLine;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: showLine
          ? BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor)))
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: highlight
                ? context.watch<MediaSettingsBloc>().state.bodyText1.bold
                : context.watch<MediaSettingsBloc>().state.bodyText1,
          ),
          Text(
            isCurrency ? Formats.currency(value) : Formats.qty(value),
            style: highlight
                ? context.watch<MediaSettingsBloc>().state.bodyText1.bold
                : context.watch<MediaSettingsBloc>().state.bodyText1.bold,
          ),
        ],
      ),
    );
  }
}
