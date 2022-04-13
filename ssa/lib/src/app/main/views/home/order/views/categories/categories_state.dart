
import 'package:single_store_app/src/app/infrastructure/error_state.dart';
import 'package:single_store_app/src/app/infrastructure/error_view.dart';
import 'package:single_store_app/src/app/infrastructure/error_view_type.dart';
import 'package:single_store_app/src/app/main/views/home/order/models/category_sitems.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';

abstract class CategoriesState {
  CategoriesState();
}

class CategoriesStateInitial extends CategoriesState {
  CategoriesStateInitial() : super();
}

class CategoriesStateError extends CategoriesState
    with ErrorState
    implements ErrorView {
  CategoriesStateError({
    required this.sysStoreCategoryId,
    required this.sysStoreCategory,
    required this.isSpecials,
    required this.error,
    this.categorySitems,
  }) : super();

  final String sysStoreCategoryId;
  final String sysStoreCategory;
  final bool isSpecials;
  final dynamic error;
  final List<CategorySitems>? categorySitems;

  @override
  ErrorViewType viewTypeFromError() {
    return errorViewTypeFromError(error);
  }

  @override
  List<String>? viewErrorMessage() {
    return errorMessageFromException(error);
  }
}

class CategoriesStatePending extends CategoriesState {
  CategoriesStatePending({
    required this.sysStoreCategoryId,
  }) : super();

  final String sysStoreCategoryId;
}

class CategoriesStateProcessing extends CategoriesState {
  CategoriesStateProcessing({
    required this.sysStoreCategoryId,
  }) : super();

  final String sysStoreCategoryId;
}

class CategoriesStateLoad extends CategoriesState {
  CategoriesStateLoad({
    required this.sysStoreCategoryId,
    required this.sysStoreCategory,
    required this.sitems,
  }) : super();

  final String sysStoreCategoryId;
  final String sysStoreCategory;
  final List<Sitem> sitems;
}

class CategoriesStateRangeBegin extends CategoriesState {
  CategoriesStateRangeBegin() : super();
}

class CategoriesStateRangeFinish extends CategoriesState {
  CategoriesStateRangeFinish() : super();
}

class CategoriesStateRange extends CategoriesState {
  CategoriesStateRange({
    required this.categorySitems,
  }) : super();

  final List<CategorySitems> categorySitems;
}
