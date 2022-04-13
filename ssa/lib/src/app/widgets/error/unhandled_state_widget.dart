import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_state.dart';

class UnhandledStateWidget extends StatelessWidget {
  const UnhandledStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaSettingsState mediaState =
        BlocProvider.of<MediaSettingsBloc>(context).state;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.engineering,
            size: mediaState.sp64,
          ),
          Container(
            margin: EdgeInsets.only(top: mediaState.sp24),
            child: Text(
              unhandledStateWidgetTitle,
              style: mediaState.headline6,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: mediaState.sp24),
            child: Column(
              children: <Widget>[
                Text(
                  unhandledStateWidgetLine1,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(top: mediaState.sp24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
