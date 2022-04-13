import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/app_repo_auth/app_repo_auth_cubit.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/storage/storage_cubit.dart';

import 'app_repo_state.dart';

class AppRepoCubit extends Cubit<AppRepoState> {
  AppRepoCubit({
    required BusinessSelectBloc businessSelectBloc,
    required AppRepoAuthCubit appRepoAuthCubit,
    required StorageCubit storageCubit,
  }) : super(AppRepoState(
          businessSelectBloc: businessSelectBloc,
          appRepoAuthCubit: appRepoAuthCubit,
          storageCubit: storageCubit,
        ));
}
