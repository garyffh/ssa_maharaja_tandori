import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/privacy_policy_repo.dart';

import 'privacy_policy_event.dart';
import 'privacy_policy_state.dart';

class PrivacyPolicyBloc extends Bloc<PrivacyPolicyEvent, PrivacyPolicyState> {
  PrivacyPolicyBloc({
    required this.privacyPolicyRepo,
  }) : super(const PrivacyPolicyStateInitial()) {
    on<PrivacyPolicyEventGetViewModel>((event, emit) async {
      try {
        emit(const PrivacyPolicyStateLoadingError());

        emit(PrivacyPolicyStateViewModel(
          privacyPolicyText: await privacyPolicyRepo.getPrivacyPolicy(),
        ));
      } catch (e) {
        emit(PrivacyPolicyStateLoadingError(error: e));
      }
    });
  }

  final PrivacyPolicyRepo privacyPolicyRepo;
}
