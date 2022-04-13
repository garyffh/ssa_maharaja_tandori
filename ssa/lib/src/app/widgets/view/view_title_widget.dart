import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class ViewTitleWidget extends StatelessWidget {
  const ViewTitleWidget({
    required this.title,
    this.trailingWidget,
    this.textLeft = true,
    this.leadPadding = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget? trailingWidget;
  final bool textLeft;
  final bool leadPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.watch<MediaSettingsBloc>().state.sp(32),
      decoration: BoxDecoration(
        color: Theme.of(context).titleBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (leadPadding)
                        SizedBox(
                          width:
                              context.watch<MediaSettingsBloc>().state.sp(27),
                        ),
                      Expanded(
                        child: Text(
                          title,
                          textAlign: textLeft ? TextAlign.left : TextAlign.center,
                          style: context
                              .watch<MediaSettingsBloc>()
                              .state
                              .headline6
                              .apply(color: Theme.of(context).titleColor),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailingWidget != null)
                  Row(
                    children: [
                      trailingWidget!,
                      context
                          .watch<MediaSettingsBloc>()
                          .state
                          .formFieldPaddingW,
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
