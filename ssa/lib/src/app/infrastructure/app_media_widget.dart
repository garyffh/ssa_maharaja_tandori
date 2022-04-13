import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/app_media_device.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_event.dart';

class AppMediaWidget extends StatelessWidget {
  const AppMediaWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        return OrientationBuilder(builder: (
          context,
          orientation,
        ) {
          context.read<MediaSettingsBloc>()
              .add(MediaSettingsEventUpdate(
            appMediaDevice: AppMediaDevice(
              themeData: Theme.of(context),
              orientation: orientation,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            ),
          ));

          return builder(context);
        });
      },
    );
  }
}
