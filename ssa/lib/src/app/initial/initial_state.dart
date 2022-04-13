import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';

import 'initial_store.dart';

part 'initial_state.g.dart';

@immutable
abstract class InitialState extends ProgressErrorState {
  const InitialState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class InitialStateProgressError extends InitialState {
  const InitialStateProgressError({dynamic error})
      : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}

@JsonSerializable()
class InitialStateLoaded extends InitialState {
  const InitialStateLoaded({
    required this.applicationName,
    required this.theme,
    required this.newAccounts,
    required this.signInRequired,
    required this.hasEnterpriseApp,
    required this.isMultiStore,
    required this.stores,
  }) : super(
          type: ProgressErrorStateType.loaded,
        );

  factory InitialStateLoaded.fromJson(Map<String, dynamic> json) =>
      _$InitialStateLoadedFromJson(json);

  Map<String, dynamic> toJson() => _$InitialStateLoadedToJson(this);

  final String applicationName;
  final String theme;
  final bool newAccounts;
  final bool signInRequired;
  final bool hasEnterpriseApp;
  final bool isMultiStore;

  final List<InitialStore> stores;
}
