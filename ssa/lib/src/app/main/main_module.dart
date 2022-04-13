import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/main/repos/authentication_repo.dart';
import 'package:single_store_app/src/app/main/repos/cart_repo.dart';
import 'package:single_store_app/src/app/main/repos/store_status_repo.dart';
import 'package:single_store_app/src/app/main/services/app_firebase/app_firebase_bloc.dart';
import 'package:single_store_app/src/app/main/services/app_firebase/app_firebase_event.dart';
import 'package:single_store_app/src/app/main/services/app_firebase/app_firebase_state.dart';
import 'package:single_store_app/src/app/main/services/app_firebase_messaging/app_firebase_messaging_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_bloc.dart';
import 'package:single_store_app/src/app/main/services/authentication/authentication_event.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_bloc.dart';
import 'package:single_store_app/src/app/main/services/cart/cart_event.dart';
import 'package:single_store_app/src/app/main/services/cart_nav/cart_nav_cubit.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status/store_status_event.dart';
import 'package:single_store_app/src/app/main/services/store_status_display/store_status_display_bloc.dart';
import 'package:single_store_app/src/app/main/services/store_status_poll/store_status_poll_bloc.dart';
import 'package:single_store_app/src/app/main/services/trn_order_messaging/trn_order_messaging_bloc.dart';
import 'package:single_store_app/src/app/main/services/user_business/user_business_bloc.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/repos/storage_repo.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_messaging/app_messaging_cubit.dart';
import 'package:single_store_app/src/app/services/app_repo_auth/app_repo_auth_cubit.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';
import 'package:single_store_app/src/app/services/app_snack_bar/app_snack_bar_cubit.dart';
import 'package:single_store_app/src/app/services/app_theme/app_theme_bloc.dart';
import 'package:single_store_app/src/app/services/business_settings/business_settings_bloc.dart';
import 'package:single_store_app/src/app/services/storage/storage_cubit.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/splash_widget.dart';

import 'main_bloc.dart';
import 'main_route.dart';

class MainModule extends StatelessWidget {
  const MainModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CartRepo>(
          create: (context) => CartRepo(
            appRepoCubit: RepositoryProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<AuthenticationRepo>(
          create: (context) => AuthenticationRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
        RepositoryProvider<StoreStatusRepo>(
          create: (context) => StoreStatusRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              storageCubit: BlocProvider.of<StorageCubit>(context),
              authenticationRepo:
                  RepositoryProvider.of<AuthenticationRepo>(context),
              appThemeBloc: BlocProvider.of<AppThemeBloc>(context),
              appRepoAuthCubit: BlocProvider.of<AppRepoAuthCubit>(context),
            )..add(AuthenticationEventRefreshToken()),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => AppFirebaseBloc(
              appThemeBloc: BlocProvider.of<AppThemeBloc>(context),
            )..add(AppFirebaseEventInitialise()),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => AppFirebaseMessagingBloc(
              storageRepo: RepositoryProvider.of<StorageRepo>(context),
              authenticationRepo:
                  RepositoryProvider.of<AuthenticationRepo>(context),
              appThemeBloc: BlocProvider.of<AppThemeBloc>(context),
              appFirebaseBloc: BlocProvider.of<AppFirebaseBloc>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              appMessagingCubit: BlocProvider.of<AppMessagingCubit>(context),
              appSnackBarCubit: BlocProvider.of<AppSnackBarCubit>(context),
              businessSettingsBloc:
                  BlocProvider.of<BusinessSettingsBloc>(context),
            ),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => TrnOrderMessagingBloc(
              appMessagingCubit: BlocProvider.of<AppMessagingCubit>(context),
              businessSettingsBloc:
                  BlocProvider.of<BusinessSettingsBloc>(context),
              appSnackBarCubit: BlocProvider.of<AppSnackBarCubit>(context),
            ),
          ),
          BlocProvider(
            create: (context) => MainBloc(),
          ),
          BlocProvider(create: (context) => StoreStatusPollBloc()),
          BlocProvider(
            lazy: false,
            create: (context) => StoreStatusBloc(
              storeStatusPollBloc:
                  BlocProvider.of<StoreStatusPollBloc>(context),
              storeStatusRepo: RepositoryProvider.of<StoreStatusRepo>(context),
              businessSettingsBloc:
                  BlocProvider.of<BusinessSettingsBloc>(context),
            )..add(StoreStatusEventInitialise()),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => UserBusinessBloc(
              businessSettingsBloc:
                  BlocProvider.of<BusinessSettingsBloc>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            ),
          ),
          BlocProvider(lazy: false,
            create: (context) => CartNavCubit(),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => CartBloc(
              appFloatingButtonCubit: BlocProvider.of<AppFloatingButtonCubit>(context),
              cartNavCubit: BlocProvider.of<CartNavCubit>(context),
              storageCubit: BlocProvider.of<StorageCubit>(context),
              cartRepo: RepositoryProvider.of<CartRepo>(context),
              userBusinessBloc: BlocProvider.of<UserBusinessBloc>(context),
            )..add(CartEventLoadFromStore()),
          ),
          BlocProvider(create: (context) => StoreStatusDisplayBloc()),
        ],
        child: BlocBuilder<AppFirebaseBloc, AppFirebaseState>(
            builder: (context, state) {
          if (state.initialised) {
            return const MainRoute();
          } else {
            return Scaffold(
              body: _firebaseProgressView(context, state),
            );
          }
        }),
      ),
    );
  }

  Widget _firebaseProgressView(
      BuildContext context, AppFirebaseState appFirebaseState) {
    switch (appFirebaseState.type) {
      case ProgressErrorStateType.loaded:
      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const SplashWidget();
        }

      case ProgressErrorStateType.loadingError:
      case ProgressErrorStateType.progressError:
        {
          return ProgressErrorWidget(
            progressErrorState: appFirebaseState,
            dataDirection: DataDirection.none,
            tryAgainCallback: () => BlocProvider.of<AppFirebaseBloc>(context)
                .add(AppFirebaseEventInitialise()),
            progressWidget: const SplashWidget(),
          );
        }
    }
  }
}
