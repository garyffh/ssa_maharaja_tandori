import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class LineQtyCell extends StatelessWidget {
  const LineQtyCell({
    required this.show,
    required this.isScale,
    required this.qty,
    Key? key,
  }) : super(key: key);

  final bool show;
  final bool isScale;
  final double qty;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: Container(
        padding: EdgeInsets.all(
          context.watch<MediaSettingsBloc>().state.sp10,
        ),
        child: show
            ? qty == 0
                ? const SizedBox.shrink()
                : Text(
                    Formats.qty(qty),
                    style: context.watch<MediaSettingsBloc>().state.bodyText1,
                    textAlign: TextAlign.center,
                  )
            : const SizedBox.shrink(),
      ),
    );
  }
}
