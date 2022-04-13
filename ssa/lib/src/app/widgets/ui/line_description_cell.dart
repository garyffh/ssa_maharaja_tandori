import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class LineDescriptionCell extends StatelessWidget {
  const LineDescriptionCell({
    required this.isCondiment,
    required this.isInstructions,
    required this.description,
    Key? key,
  }) : super(key: key);

  final bool isCondiment;
  final bool isInstructions;
  final String description;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: Container(
        padding: EdgeInsets.all(
          context.watch<MediaSettingsBloc>().state.sp10,
        ),
        child: Text(
          description,
          style: (isCondiment || isInstructions)
              ? context.watch<MediaSettingsBloc>().state.bodyText2
              : context.watch<MediaSettingsBloc>().state.bodyText1,
        ),
      ),
    );
  }
}
