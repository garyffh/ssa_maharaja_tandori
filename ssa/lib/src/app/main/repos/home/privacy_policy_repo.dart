import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/privacy/privacy_policy_text.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class PrivacyPolicyRepo extends AppRepo {
  PrivacyPolicyRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
    appRepoCubit: appRepoCubit,
    multiStoreUrl: false,
  );


  Future<PrivacyPolicyText> getPrivacyPolicy() async {
    return PrivacyPolicyText.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'privacy',
        apiSegment: null,
      ),
    );
  }

}
