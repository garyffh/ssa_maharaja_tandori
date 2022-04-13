import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/strings/no_internet_widget.constants.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import '../ui/try_again_button.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    this.tryAgainCallback,
    this.tryAgainButtonText,
    Key? key,
  }) : super(key: key);

  final VoidCallback? tryAgainCallback;
  final String? tryAgainButtonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.portable_wifi_off,
            size: context.watch<MediaSettingsBloc>().state.sp56,
          ),
          Container(
            margin: EdgeInsets.only(
              top: context.watch<MediaSettingsBloc>().state.sp20,
            ),
            child: Text(
              noInternetWidgetTitle,
              style: context.watch<MediaSettingsBloc>().state.headline6,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: context.watch<MediaSettingsBloc>().state.sp14,
            ),
            child: Text(
              noInternetWidgetLine1,
              style: context.watch<MediaSettingsBloc>().state.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: context.watch<MediaSettingsBloc>().state.sp14,
            ),
            child: Text(
              noInternetWidgetLine2,
              style: context.watch<MediaSettingsBloc>().state.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          if (tryAgainCallback != null)
            Container(
              margin: EdgeInsets.only(
                  top: context.watch<MediaSettingsBloc>().state.sp18),
              child: TryAgainButton(
                onPressed: tryAgainCallback!,
                buttonText: tryAgainButtonText,
              ),
            ),
        ],
      ),
    );
  }
}
