import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class FormErrorMessageWidget extends StatelessWidget {
  const FormErrorMessageWidget({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  final List<String>? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) {
      return Container(
        constraints: BoxConstraints(
          minHeight: context.watch<MediaSettingsBloc>().state.sp30,
          minWidth: double.infinity,
        ),
      );
    } else {
      return Container(
        constraints: BoxConstraints(
          minHeight: context.watch<MediaSettingsBloc>().state.sp30,
          minWidth: double.infinity,
        ),
        child: Container(
          padding: EdgeInsets.symmetric( horizontal:  context.watch<MediaSettingsBloc>().state.sp16),
        child: Column(
          children: _errorLines(context, errorMessage!),
        ),
        ),
      );
    }
  }

  List<Widget> _errorLines(BuildContext context, List<String> message) {
    final List<Widget> rtn = List<Widget>.empty(growable: true);
    for (int index = 0; index < message.length; index++) {
      if (index == 0) {
        rtn.add(Text(
          message[index],
          style: context.watch<MediaSettingsBloc>().state.subtitle1.apply(
                color: Theme.of(context).colorScheme.error,
              ),
        ));
      } else {
        rtn.add(Text(
          message[index],
          style: context.watch<MediaSettingsBloc>().state.bodyText2.apply(
                color: Theme.of(context).colorScheme.error,
              ),
        ));
      }
    }

    return rtn;
  }
}
