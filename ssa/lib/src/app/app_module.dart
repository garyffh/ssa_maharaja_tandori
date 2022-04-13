import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_bloc.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_state.dart';

import 'app_route.dart';
import 'infrastructure/app_media_widget.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, appThemeState) {
          return MaterialApp(
            debugShowCheckedModeBanner:  defaultTargetPlatform != TargetPlatform.iOS,
            theme: appThemeState.lightThemeData,
            darkTheme: appThemeState.darkThemeData,
            themeMode: appThemeState.themeMode,
            navigatorKey: context.read<AppNavigatorCubit>().state.navigatorKey,
            home: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AppMediaWidget(
                builder: (context) => const AppRoute(),
              ),
            ),
          );
        },
    );
  }
}
