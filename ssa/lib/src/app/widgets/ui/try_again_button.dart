import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/try_again_button.constants.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class TryAgainButton extends StatelessWidget {
   const TryAgainButton({
    required this.onPressed,
    this.buttonText,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: context.watch<MediaSettingsBloc>().state.elevatedButtonStyle,
      onPressed: () => onPressed(),
      child: Text(
        buttonText == null ? tryAgainButtonText : buttonText!,
        style: context.watch<MediaSettingsBloc>().state.elevatedButtonTextStyle,
      ),
    );
  }
}
