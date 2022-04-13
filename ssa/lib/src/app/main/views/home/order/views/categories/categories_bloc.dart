import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/home/categories_repo.dart';
import 'package:single_store_app/src/app/main/views/home/order/models/category_sitems.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/widgets/categories_tab_widget/models/store_category_event.dart';
import 'package:single_store_app/src/app/models/business/store_category_read.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';

import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required this.categoriesRepo})
      : super(CategoriesStateInitial()) {
    on<CategoriesEventGetSitems>((event, emit) async {
      List<CategorySitems>? errorCategorySitems;
      final String errorSysStoreCategoryId = event.sysStoreCategoryId;
      final String errorSysStoreCategory = event.sysStoreCategory;
      final bool errorIsSpecials = event.isSpecials;

      try {
        emit(CategoriesStateProcessing(
            sysStoreCategoryId: event.sysStoreCategoryId));

        late List<Sitem> sitems;

        if (event.isSpecials) {
          sitems = await categoriesRepo.readSpecialSitems();
        } else {
          sitems = await categoriesRepo.readCategorySitems(
            sysStoreCategoryId: event.sysStoreCategoryId,
          );
        }

        emit(CategoriesStateLoad(
          sysStoreCategoryId: event.sysStoreCategoryId,
          sysStoreCategory: event.sysStoreCategory,
          sitems: sitems,
        ));
      } catch (e) {
        emit(CategoriesStateError(
            sysStoreCategoryId: errorSysStoreCategoryId,
            sysStoreCategory: errorSysStoreCategory,
            categorySitems: errorCategorySitems,
            isSpecials: errorIsSpecials,
            error: e));
      }
    });

    on<CategoriesEventGetSitemRange>((event, emit) async {
      String errorSysStoreCategoryId = '';
      String errorSysStoreCategory = '';
      bool errorIsSpecials = false;

      List<CategorySitems>? errorCategorySitems;

      try {
        if (event.storeCategories.isNotEmpty) {
          emit(CategoriesStateRangeBegin());

          final List<CategorySitems> categorySitems = [];

          try {
            for (final StoreCategoryEvent category in event.storeCategories) {
              errorSysStoreCategoryId = category.sysStoreCategoryId;
              errorSysStoreCategory = category.name;
              errorIsSpecials = category.isSpecials;

              late List<Sitem> sitems;

              if (category.isSpecials) {
                sitems = await categoriesRepo.readSpecialSitems();
              } else {
                sitems = await categoriesRepo.readCategorySitems(
                  sysStoreCategoryId: category.sysStoreCategoryId,
                );
              }

              categorySitems.add(CategorySitems(
                category: StoreCategoryRead(
                  sysStoreCategoryId: category.sysStoreCategoryId,
                  number: category.number,
                  name: category.name,
                ),
                sitems: sitems,
              ));
            }

            emit(CategoriesStateRange(
              categorySitems: categorySitems,
            ));
          } catch (e) {
            errorCategorySitems = categorySitems;
            rethrow;
          } finally {
            emit(CategoriesStateRangeFinish());
          }
        }
      } catch (e) {
        emit(CategoriesStateError(
            sysStoreCategoryId: errorSysStoreCategoryId,
            sysStoreCategory: errorSysStoreCategory,
            categorySitems: errorCategorySitems,
            isSpecials: errorIsSpecials,
            error: e));
      }
    });
  }

  final CategoriesRepo categoriesRepo;

}
