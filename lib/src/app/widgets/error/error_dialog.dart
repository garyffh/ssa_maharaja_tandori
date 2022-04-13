import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    required this.errorMessage,
    required this.onContinue,
    Key? key,
  }) : super(key: key);

  final List<String>? errorMessage;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            context.watch<MediaSettingsBloc>().state.sp8,
          ),
        ),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: context.watch<MediaSettingsBloc>().state.sp(80),
        ),
        padding: EdgeInsets.all(context.watch<MediaSettingsBloc>().state.sp20),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(
            context.watch<MediaSettingsBloc>().state.sp8,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: context.watch<MediaSettingsBloc>().state.sp10,
              offset:
              Offset(0.0, context.watch<MediaSettingsBloc>().state.sp10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Error',
              style: context.watch<MediaSettingsBloc>().state.headline6,
            ),
            const Divider(),
            context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            ..._buildErrorMessageLines(context),
            context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            Container(
              margin: EdgeInsets.only(
                top: context.watch<MediaSettingsBloc>().state.sp8,
              ),
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  context.watch<MediaSettingsBloc>().state.formFieldPaddingW,
                  TextButton(
                    style: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .dialogButtonStyle,
                    onPressed: onContinue,
                    child: Text(
                      'CONTINUE',
                      style: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .dialogButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          style: context.watch<MediaSettingsBloc>().state.bodyText1,
          textAlign: TextAlign.center,
        ));
      }
    } else {
      rtn.add(Text(
        'Unknown Error',
        style: context.watch<MediaSettingsBloc>().state.bodyText1,
        textAlign: TextAlign.center,
      ));
    }

    return rtn;
  }

}
