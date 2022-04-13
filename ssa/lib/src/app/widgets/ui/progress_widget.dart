import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    this.dataDirection = DataDirection.none,
    Key? key,
  }) : super(key: key);

  final DataDirection dataDirection;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.watch<MediaSettingsBloc>().state.sp32,
            width: context.watch<MediaSettingsBloc>().state.sp32,
            child: CircularProgressIndicator(
              strokeWidth: context.watch<MediaSettingsBloc>().state.sp10,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: context.watch<MediaSettingsBloc>().state.sp16,
            ),
            child: Text(
              dataDirection.text,
              style: context.watch<MediaSettingsBloc>().state.bodyText2,
            ),
          ),
        ],
      ),
    );
  }


}
