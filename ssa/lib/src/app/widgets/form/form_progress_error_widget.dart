import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/form_progress_error_widget.constants.dart';
import 'package:single_store_app/src/app/infrastructure/progress_form_view.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/ui/try_again_button.dart';
import 'form_error_message_widget.dart';

class FormProgressErrorWidget extends StatelessWidget {
  const FormProgressErrorWidget({
    required this.progressFormView,
    this.progressText = formProgressErrorWidgetText,
    this.tryAgainCallback,
    this.progressWidget,
    Key? key,
  }) : super(key: key);

  final ProgressFormView progressFormView;
  final String progressText;
  final VoidCallback? tryAgainCallback;
  final Widget? progressWidget;

  @override
  Widget build(BuildContext context) {
    if (progressFormView.hasError) {
      return Column(
        children: [
          context.watch<MediaSettingsBloc>().state.padding,
          FormErrorMessageWidget(
            errorMessage: progressFormView.stateErrorMessage(),
          ),
          context.watch<MediaSettingsBloc>().state.padding,
          if (tryAgainCallback != null)
            Container(
              margin: context.watch<MediaSettingsBloc>().state.bottomBoxPadding,
              child: TryAgainButton(onPressed: tryAgainCallback!),
            ),
        ],
      );
    } else if (progressFormView.inProgress) {
      return Container(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        child: Column(
          children: [
            SizedBox(
              height: context.watch<MediaSettingsBloc>().state.sp28,
              width: context.watch<MediaSettingsBloc>().state.sp28,
              child: CircularProgressIndicator(
                strokeWidth: context.watch<MediaSettingsBloc>().state.sp10,
              ),
            ),
            context.watch<MediaSettingsBloc>().state.padding,
            Text(
              progressText,
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
