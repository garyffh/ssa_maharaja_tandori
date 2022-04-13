import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/models/products/sitem_detail.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class SitemRepo extends AppRepo {
  SitemRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<SitemDetail> findSitemDetail({
    required String sysSitemId,
  }) async {
    return SitemDetail.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'sitem/detail',
        apiSegment: sysSitemId,
      ),
    );
  }

  Future<SitemDetail> findNextDetail({
    required int pagePosition,
  }) async {
    return SitemDetail.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'sitem/next-detail',
        apiSegment: '$pagePosition',
      ),
    );
  }

  Future<SitemDetail> findPreviousDetail({
    required int pagePosition,
  }) async {
    return SitemDetail.fromJson(
      await httpGetJsonDecode(
        controllerSegment: 'sitem/previous-detail',
        apiSegment: '$pagePosition',
      ),
    );
  }
}
