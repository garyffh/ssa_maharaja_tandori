import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/business/store_status.dart';
import 'package:single_store_app/src/app/models/business/store_status_find.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class StoreStatusRepo extends AppRepo {
  StoreStatusRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
    appRepoCubit: appRepoCubit,
    multiStoreUrl: true,
  );

  Future<StoreStatus> findStoreStatus(StoreStatusFind content) async {
    return StoreStatus.fromJson(
      await httpPutJsonDecode(
        controllerSegment: 'store-status',
        apiSegment: null,
        jsonObject: content,
      ),
    );
  }


}
