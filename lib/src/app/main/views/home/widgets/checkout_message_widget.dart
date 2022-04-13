import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class CheckoutMessageWidget extends StatelessWidget {
  const CheckoutMessageWidget({
    required this.message,
    required this.error,
    Key? key,
  }) : super(key: key);

  final List<String> message;
  final bool error;

  @override
  Widget build(BuildContext context) {
    if (error) {
      return Container(
        padding: EdgeInsets.symmetric(
            vertical: context.watch<MediaSettingsBloc>().state.formPadding),
        child: Column(
          children: List.generate(
            message.length,
                (index) => Text(
              message[index],
              style: context.watch<MediaSettingsBloc>().state.bodyText1.apply(
                color: Theme.of(context).colorScheme.error,
              ),
                  textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
            vertical: context.watch<MediaSettingsBloc>().state.formPadding),
        child: Column(
          children: List.generate(
            message.length,
                (index) => Text(
              message[index],
              style: context.watch<MediaSettingsBloc>().state.bodyText1,
                  textAlign: TextAlign.center,
            ),

          ),
        ),
      );
    }
  }
}
