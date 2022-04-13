import 'package:elevated_progress_button/elevated_progress_button.dart';
import 'package:elevated_progress_button/elevated_progress_button_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_form_view.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class FormProgressButtonSmall extends StatelessWidget {
  const FormProgressButtonSmall(
      {required this.text,
        this.iconData,
        required this.progressFormView,
        required this.onPressed,
        this.dataDirection = DataDirection.none,
        Key? key})
      : super(key: key);

  final String text;
  final IconData? iconData;
  final ProgressFormView progressFormView;
  final VoidCallback? onPressed;
  final DataDirection dataDirection;

  @override
  Widget build(BuildContext context) {
    return ElevatedProgressButton(
      progressButtonStates: {
        ProgressButtonState.idle: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.idle,
          spacing: context.watch<MediaSettingsBloc>().state.buttonIconSpacing,
          text: text,
          icon: iconData == null
              ? null
              : Icon(
            iconData,
            size: context.watch<MediaSettingsBloc>().state.buttonIconSize,
          ),
        ),
        ProgressButtonState.progress: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.progress,
          spacing: context.watch<MediaSettingsBloc>().state.buttonIconSpacing,
          text: dataDirection.text,
        ),
        ProgressButtonState.fail: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.fail,
          spacing: context.watch<MediaSettingsBloc>().state.buttonIconSpacing,
          text: 'Continue',
          icon: Icon(
            Icons.arrow_right,
            size: context.watch<MediaSettingsBloc>().state.buttonIconSize,
          ),
        ),
        ProgressButtonState.success: ElevatedProgressButtonState(
          progressButtonState: ProgressButtonState.success,
          spacing: context.watch<MediaSettingsBloc>().state.buttonIconSpacing,
          text: '',
          icon: Icon(
            Icons.check_circle,
            size: context.watch<MediaSettingsBloc>().state.buttonIconSize,
          ),
        ),
      },

      size: context.watch<MediaSettingsBloc>().state.sp18,
      radius: context.watch<MediaSettingsBloc>().state.sp18,
      padding: context.watch<MediaSettingsBloc>().state.sp12,
      minWidth: context.watch<MediaSettingsBloc>().state.sp32,
      maxWidth: context.watch<MediaSettingsBloc>().state.sp(58),
      progressIndicatorColor: Theme.of(context).primaryTextColor,
      state: buttonState(),
      onPressed: onPressed,
      minWidthStates: dataDirection == DataDirection.none
          ? <ProgressButtonState>[ProgressButtonState.progress]
          : [],
    );
  }

  ProgressButtonState buttonState() {
    switch (progressFormView.viewType) {
      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loaded:
      case ProgressErrorStateType.idle:
        return ProgressButtonState.idle;

      case ProgressErrorStateType.loadingError:
      case ProgressErrorStateType.progressError:
        {
          if (progressFormView.hasError) {
            return ProgressButtonState.fail;
          } else {
            return ProgressButtonState.progress;
          }
        }

      case ProgressErrorStateType.submitted:
        return ProgressButtonState.success;
    }
  }
}
