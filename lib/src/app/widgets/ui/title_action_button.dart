import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class TitleActionButton extends StatelessWidget {
  const TitleActionButton({
    required this.onPressed,
    this.label,
    this.iconData,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String? label;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {

    return TextButton.icon(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).titleColor),
      ),
      label: Text(
        label == null ? 'ADD' : label!,
        style: context.watch<MediaSettingsBloc>().state.titleActionTextStyle,
      ),
      icon: Icon(
        iconData == null ? Icons.add : iconData!,
        size: context.watch<MediaSettingsBloc>().state.titleActionIconSize,
      ),
      onPressed: onPressed,
    );
  }
}
