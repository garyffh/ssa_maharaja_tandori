import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_state.dart';

class AppMessageWidget extends StatefulWidget {
  const AppMessageWidget({Key? key}) : super(key: key);

  @override
  State<AppMessageWidget> createState() => _AppMessageWidgetState();
}

class _AppMessageWidgetState extends State<AppMessageWidget> {
  AppMessagingState appMessagingState = const AppMessagingStateInitial();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppMessagingCubit, AppMessagingState>(
      listener: (context, state) {
        setState(
          () => appMessagingState = AppMessagingPublished.copyWith(state),
        );
      },
      child: ListTile(
        title: Text(
            appMessagingState.title == null ? '' : appMessagingState.title!),
        subtitle:
            Text(appMessagingState.body == null ? '' : appMessagingState.body!),
      ),
    );
  }
}
