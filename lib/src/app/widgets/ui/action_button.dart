import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.onPressed,
    required this.text,
    this.text2,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final String? text2;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.watch<MediaSettingsBloc>().state.allBoxPadding,
      constraints: BoxConstraints(
          minWidth: context.watch<MediaSettingsBloc>().state.sp(70)),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            children: [
              Text(
                text,
                style: context.watch<MediaSettingsBloc>().state.subtitle1,
                textAlign: TextAlign.center,
              ),
              if (text2 != null)
                Text(
                  text2!,
                  style: context.watch<MediaSettingsBloc>().state.subtitle1,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
          FloatingActionButton(
            onPressed: () => onPressed(),
            child: Icon(iconData),
          ),
        ],
      ),
    );
  }
}
