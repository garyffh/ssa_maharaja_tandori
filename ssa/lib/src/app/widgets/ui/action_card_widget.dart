import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

import 'action_card_widget_type.dart';

class ActionCardWidget extends StatelessWidget {
  const ActionCardWidget({
    required this.title,
    required this.content,
    this.actionCardWidgetType = ActionCardWidgetType.none,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget content;
  final ActionCardWidgetType actionCardWidgetType;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(context.watch<MediaSettingsBloc>().state.sp16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                  context.watch<MediaSettingsBloc>().state.subtitle2.bold,
                ),
                if (onPressed != null && actionCardWidgetType != ActionCardWidgetType.none)
                  TextButton.icon(
                    icon: Text(
                      actionCardWidgetType.text,
                      style: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .titleActionTextStyle,
                    ),
                    label: Icon(
                      actionCardWidgetType.iconData,
                      color: Theme.of(context).iconTheme.color,
                      size: context
                          .watch<MediaSettingsBloc>()
                          .state
                          .titleActionIconSize,
                    ),
                    onPressed: () => onPressed!(),
                  ),
              ],
            ),
            const Divider(
              thickness: 2.0,
            ),
            context.watch<MediaSettingsBloc>().state.formFieldPaddingH,
            content,
          ],
        ),
      ),
    );
  }
}
