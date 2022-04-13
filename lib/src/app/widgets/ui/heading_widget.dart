import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/theme_data_extensions.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    required this.heading,
    this.trailingWidget,
    Key? key,
  }) : super(key: key);

  final String heading;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.watch<MediaSettingsBloc>().state.sp(28),
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
                      SizedBox(
                        width: context.watch<MediaSettingsBloc>().state.sp(18),
                      ),
                      Expanded(
                        child: Text(
                          heading,
                          textAlign: TextAlign.left,
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
