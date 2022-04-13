import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  final String title;
  final String content;

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
              title,
              style: context.watch<MediaSettingsBloc>().state.headline6,
            ),
            const Divider(),
            context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            Text(
              content,
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
            ),
            context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            Container(
              margin: EdgeInsets.only(
                top: context.watch<MediaSettingsBloc>().state.sp8,
              ),
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                style:
                    context.watch<MediaSettingsBloc>().state.dialogButtonStyle,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'CLOSE',
                  style: context
                      .watch<MediaSettingsBloc>()
                      .state
                      .dialogButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
