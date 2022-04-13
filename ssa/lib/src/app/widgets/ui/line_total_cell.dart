import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';

import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class LineTotalCell extends StatelessWidget {
  const LineTotalCell({
    required this.isCondiment,
    required this.total,
    Key? key,
  }) : super(key: key);

  final bool isCondiment;
  final double total;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: Container(
        padding: EdgeInsets.all(
          context.watch<MediaSettingsBloc>().state.sp10,
        ),
        child: total == 0
            ? const SizedBox.shrink()
            : Text(
                Formats.currency(total),
                style: context.watch<MediaSettingsBloc>().state.bodyText1,
                textAlign: TextAlign.right,
              ),
      ),
    );
  }
}

