import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/privacy/privacy_policy_text.dart';

@immutable
abstract class PrivacyPolicyState extends ProgressErrorState {
  const PrivacyPolicyState({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class PrivacyPolicyStateInitial extends PrivacyPolicyState {
  const PrivacyPolicyStateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class PrivacyPolicyStateLoadingError extends PrivacyPolicyState {
  const PrivacyPolicyStateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class PrivacyPolicyStateViewModel extends PrivacyPolicyState {
  const PrivacyPolicyStateViewModel({
    required this.privacyPolicyText,
  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final PrivacyPolicyText privacyPolicyText;
}
