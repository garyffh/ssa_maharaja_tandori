import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/form_confirmation_widget.constants.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/ui/continue_button.dart';

class FormConfirmationWidget extends StatelessWidget {
  const FormConfirmationWidget({
    required this.message,
    this.continueCallback,
    Key? key,
  }) : super(key: key);

  final List<String>? message;
  final VoidCallback? continueCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: context.watch<MediaSettingsBloc>().state.sp32,
          ),
          Container(
            margin: EdgeInsets.only(
                top: context.watch<MediaSettingsBloc>().state.sp20),
            child: Text(
              formConfirmationWidgetTitle,
              style: context.watch<MediaSettingsBloc>().state.headline6,
            ),
          ),
          if (message != null)
            Container(
              margin: EdgeInsets.only(
                  top: context.watch<MediaSettingsBloc>().state.sp14),
              child: Column(
                children: _messageLines(context),
              ),
            ),
          if (continueCallback != null)
            Container(
              margin: EdgeInsets.only(
                  top: context.watch<MediaSettingsBloc>().state.sp18),
              child: ContinueButton(onPressed: continueCallback!),
            ),
        ],
      ),
    );
  }

  List<Widget> _messageLines(
    BuildContext context,
  ) {
    final List<Widget> rtn = [];

    for (final String line in message!) {
      rtn.add(Text(
        line,
        style: context.watch<MediaSettingsBloc>().state.bodyText2,
        textAlign: TextAlign.center,
      ));
    }

    return rtn;
  }
}
