import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    required this.label,
    Key? key,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(
          context.watch<MediaSettingsBloc>().state.sp16,
        ),
        child: Text(
          label,
          style: context.watch<MediaSettingsBloc>().state.subtitle1,
        ),
      ),
    );
  }
}
