import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class ActionButtonVertical extends StatelessWidget {
  const ActionButtonVertical({
    required this.onPressed,
    required this.text,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.watch<MediaSettingsBloc>().state.allBoxPadding,
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => onPressed(),
            child: Icon(iconData),
          ),
          SizedBox( height: context.watch<MediaSettingsBloc>().state.sp16),
          Text(text,
              style: context.watch<MediaSettingsBloc>().state.subtitle1),

        ],
      ),
    );
  }
}
