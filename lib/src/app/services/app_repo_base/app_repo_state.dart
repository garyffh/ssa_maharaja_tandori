import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/services/app_repo_auth/app_repo_auth_cubit.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/storage/storage_cubit.dart';

@immutable
class AppRepoState {
  const AppRepoState({
    required this.businessSelectBloc,
    required this.appRepoAuthCubit,
    required this.storageCubit,
  });

  final BusinessSelectBloc businessSelectBloc;
  final AppRepoAuthCubit appRepoAuthCubit;
  final StorageCubit storageCubit;
}
