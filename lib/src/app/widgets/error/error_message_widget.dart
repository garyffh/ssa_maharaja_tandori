import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/failed_widget.constants.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import '../ui/try_again_button.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    required this.errorMessage,
    this.tryAgainCallback,
    this.tryAgainButtonText,
    Key? key,
  }) : super(key: key);

  final List<String>? errorMessage;
  final VoidCallback? tryAgainCallback;
  final String? tryAgainButtonText;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            size: context.watch<MediaSettingsBloc>().state.sp56,
          ),
          Container(
            margin: EdgeInsets.only(
                top: context.watch<MediaSettingsBloc>().state.sp20),
            child: Text(
              failedWidgetTitle,
              style: context.watch<MediaSettingsBloc>().state.headline6,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: context.watch<MediaSettingsBloc>().state.sp14),
            child: Column(
              children: _buildErrorMessageLines(context),
            ),
          ),
          if (tryAgainCallback != null)
            Container(
              margin: EdgeInsets.only(
                  top: context.watch<MediaSettingsBloc>().state.sp18),
              child: TryAgainButton(
                onPressed: tryAgainCallback!,
                buttonText: tryAgainButtonText,
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildErrorMessageLines(
    BuildContext context,
  ) {
    final List<Widget> rtn = [];

    if (errorMessage != null) {
      for (final String line in errorMessage!) {
        rtn.add(Text(
          line,
          style: context.watch<MediaSettingsBloc>().state.bodyText2,
          textAlign: TextAlign.center,
        ));
      }
    } else {
      rtn.add(Text(
        'Unknown Error',
        style: context.watch<MediaSettingsBloc>().state.bodyText2,
        textAlign: TextAlign.center,
      ));
    }
    // rtn.add(Container(
    //   margin: const EdgeInsets.only(top: 24),
    // ));

    return rtn;
  }
}
