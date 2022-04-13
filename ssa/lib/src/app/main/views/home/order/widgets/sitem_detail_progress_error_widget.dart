import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_form_view.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/form/form_error_message_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/continue_button.dart';

class SitemDetailProgressErrorWidget extends StatelessWidget {
  const SitemDetailProgressErrorWidget({
    required this.progressFormView,
    this.continueCallback,
    Key? key,
  }) : super(key: key);

  final ProgressFormView progressFormView;
  final VoidCallback? continueCallback;

  @override
  Widget build(BuildContext context) {
    if (progressFormView.hasError) {
      return Center(
        child: Column(
          children: [
            context.watch<MediaSettingsBloc>().state.padding,
            FormErrorMessageWidget(
              errorMessage: progressFormView.stateErrorMessage(),
            ),
            context.watch<MediaSettingsBloc>().state.padding,
            if (continueCallback != null)
              Container(
                margin:
                    context.watch<MediaSettingsBloc>().state.bottomBoxPadding,
                child: ContinueButton(onPressed: continueCallback!),
              ),
          ],
        ),
      );
    } else if (progressFormView.inProgress) {
      return Container(
        constraints: const BoxConstraints(minHeight: 107.0),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
