import 'package:single_store_app/src/app/infrastructure/app_repo.dart';
import 'package:single_store_app/src/app/infrastructure/fake_repo.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

class CategoriesFakeRepo extends FakeRepo {
  CategoriesFakeRepo()
      : super(
          json: '{""}',
        );
}

class CategoriesRepo extends AppRepo {
  CategoriesRepo({
    required AppRepoCubit appRepoCubit,
  }) : super(
          appRepoCubit: appRepoCubit,
          multiStoreUrl: true,
        );

  Future<List<Sitem>> readCategorySitems(
      {required String sysStoreCategoryId, bool consolePrint = false}) async {
    return httpGetWithCacheJsonDecodeListModel<Sitem>(
      controllerSegment: 'sitem/by-store-category',
      apiSegment: sysStoreCategoryId,
      fromJson: (m) => Sitem.fromJson(m),
    );
  }

  Future<List<Sitem>> readSpecialSitems() async {
    return httpGetWithCacheJsonDecodeListModel<Sitem>(
      controllerSegment: 'sitem/specials',
      apiSegment: null,
      fromJson: (m) => Sitem.fromJson(m),
    );

    // https://pub.dev/packages/flutter_cache_manager
    /// we need to clear cache
  }

// Future<List<Sitem>>> fakeGetCategorySitems(FakeHttp fakeHttp) async {
//   try {
//     return List<Sitem>>.fromJson(
//         await CategorySitemsFakeRepo().httpGetJsonDecodeListModel<Sitem>(fakeHttp));
//   } catch (e) {
//     rethrow;
//   }
// }

}
