import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/continue_button.constants.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: context.watch<MediaSettingsBloc>().state.elevatedButtonStyle,
      onPressed: () => onPressed(),
      child: Text(
        continueButtonText,
        style: context.watch<MediaSettingsBloc>().state.elevatedButtonTextStyle,
      ),
    );
  }
}
