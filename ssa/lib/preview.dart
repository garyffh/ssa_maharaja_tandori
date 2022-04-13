import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/app_module.dart';
import 'package:single_store_app/src/app/repos/storage_repo.dart';
import 'package:single_store_app/src/app/services/app_audio/app_audio_cubit.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/app_navigator/app_navigator_cubit.dart';
import 'package:single_store_app/src/app/services/app_repo_auth/app_repo_auth_cubit.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_cubit.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_bloc.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_event.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/services/storage/storage_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Row(
    textDirection: TextDirection.ltr,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: DevicePreview(
          enabled: !kReleaseMode,
          // plugins: const [
          //   ScreenshotPlugin(),
          //   FileExplorerPlugin(),
          //   SharedPreferencesExplorerPlugin(),
          // ],
          builder: (context) => const FfhStoreApp(),
        ),
      ),
    ],
  ));
}

class FfhStoreApp extends StatelessWidget {
  const FfhStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StorageRepo>(
          create: (context) => StorageRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppFloatingButtonCubit()),
          BlocProvider(lazy: false, create: (context) => AppAudioCubit()),
          BlocProvider(
              lazy: false,
              create: (context) => AppSnackBarCubit(
                    appAudioCubit: BlocProvider.of<AppAudioCubit>(context),
                  )),
          BlocProvider(lazy: false, create: (context) => AppMessagingCubit()),
          BlocProvider(create: (context) => AppRepoAuthCubit()),
          BlocProvider(create: (context) => MediaSettingsBloc()),
          BlocProvider(create: (context) => BusinessSelectBloc()),
          BlocProvider(create: (context) => BusinessSettingsBloc(
            businessSelectBloc: BlocProvider.of<BusinessSelectBloc>(context),
          )),
          BlocProvider(
            lazy: false,
            create: (context) => StorageCubit(
              storageRepo: RepositoryProvider.of<StorageRepo>(context),
              businessSettingsBloc:
                  BlocProvider.of<BusinessSettingsBloc>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AppRepoCubit(
              businessSelectBloc: BlocProvider.of<BusinessSelectBloc>(context),
              appRepoAuthCubit: BlocProvider.of<AppRepoAuthCubit>(context),
              storageCubit: BlocProvider.of<StorageCubit>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AppThemeBloc(
              storageCubit: BlocProvider.of<StorageCubit>(context),
              businessSelectBloc: BlocProvider.of<BusinessSelectBloc>(context),
              businessSettingsBloc:
                  BlocProvider.of<BusinessSettingsBloc>(context),
            )..add(AppThemeEventThemeFromStorage()),
          ),
          BlocProvider(create: (context) => AppNavigatorCubit()),
        ],
        child: const AppModule(),
      ),
    );
  }
}
