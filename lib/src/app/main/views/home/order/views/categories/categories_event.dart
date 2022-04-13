import 'package:single_store_app/src/app/main/views/home/order/views/categories/widgets/categories_tab_widget/models/store_category_event.dart';


abstract class CategoriesEvent {
  CategoriesEvent();

}

class CategoriesEventGetSitems extends CategoriesEvent {

  CategoriesEventGetSitems({
    required this.sysStoreCategoryId,
    required this.sysStoreCategory,
    required this.isSpecials,
  }) : super();


  final String sysStoreCategoryId;
  final String sysStoreCategory;
  final bool isSpecials;

}

class CategoriesEventGetSitemRange extends CategoriesEvent {

  CategoriesEventGetSitemRange({
    required this.storeCategories,
  }) : super();



  final List<StoreCategoryEvent> storeCategories;

}
