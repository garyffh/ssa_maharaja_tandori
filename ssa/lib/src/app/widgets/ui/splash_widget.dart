import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/constants/dart_define.constants.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/ui/logo_widget.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(
            PackageConstants.logoBackgroundColour),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Opacity(
            opacity: 0.7,
            child: LogoWidget(
              boxConstraints: BoxConstraints(
                maxWidth: context.watch<MediaSettingsBloc>().state.sp(70),
              ),
            ),
          ),
          SizedBox(
            height: context.watch<MediaSettingsBloc>().state.sp32,
            width: context.watch<MediaSettingsBloc>().state.sp32,
            child: CircularProgressIndicator(
              strokeWidth: context.watch<MediaSettingsBloc>().state.sp10,
            ),
          ),
        ],
      ),
    );
  }
}
