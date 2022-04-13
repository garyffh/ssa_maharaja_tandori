
import 'package:single_store_app/src/app/models/business/store_category_read.dart';
import 'package:single_store_app/src/app/models/products/sitem.dart';

class CategorySitems {
  CategorySitems({
    required this.category,
    required this.sitems,
  });

  CategorySitems.copy(CategorySitems value)
      : this(
            category: StoreCategoryRead(
              sysStoreCategoryId: value.category.sysStoreCategoryId,
              number: value.category.number,
              name: value.category.name,
            ),
            sitems: List<Sitem>.generate(value.sitems.length,
                (index) =>  Sitem.copy(value.sitems[index]) )
  );

  final StoreCategoryRead category;
  final List<Sitem> sitems;
}
