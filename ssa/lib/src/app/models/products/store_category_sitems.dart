
import 'package:single_store_app/src/app/models/products/sitem.dart';

class StoreCategorySitems {
  StoreCategorySitems({
    required this.sysStoreCategoryId,
    required this.sitems,
  });

  final String sysStoreCategoryId;
  final List<Sitem> sitems;
}