import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
    Key? key,
  }) : super(key: key);

  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
              child: Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  TextButton(
                    style: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .dialogButtonStyle,
                    onPressed: onCancel ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Text(
                      'CANCEL',
                      style: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .dialogButtonTextStyle,
                    ),
                  ),
                  context.watch<MediaSettingsBloc>().state.formFieldPaddingW,
                  TextButton(
                    style: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .dialogButtonStyle,
                    onPressed: onConfirm,
                    child: Text(
                      'CONFIRM',
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
}
