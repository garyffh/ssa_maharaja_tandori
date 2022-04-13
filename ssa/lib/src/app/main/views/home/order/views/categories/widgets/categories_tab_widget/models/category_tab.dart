import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/widgets/categories_tab_widget/models/scrollable_list_tab.dart';

import 'list_tab.dart';

enum CategoryTabStatus { pending, processing, error, loaded }
enum CategoryTabViewStatus { pending, processing, loaded }

class CategoryTab extends ScrollableListTab {
  CategoryTab({
    required this.sysStoreCategoryId,
    required this.isSpecials,
    required this.itemCount,
    required String sysStoreCategory,
    required this.categoryTabStatus,
    required this.categoryTabViewStatus,
    required ScrollView listBody,
  }) : super(
      listTab: ListTab(
              text: sysStoreCategory,
            ),
      listBody: listBody);

  CategoryTab.initialise({
    required this.sysStoreCategoryId,
    required this.isSpecials,
    required String sysStoreCategory,
    required ScrollView listBody,
  })  : categoryTabStatus = CategoryTabStatus.pending,
        categoryTabViewStatus = CategoryTabViewStatus.pending,
        itemCount = 0,
        super(
          listTab: ListTab(
              text: sysStoreCategory,
            ),
          listBody: listBody);

  CategoryTab.copyFrom(
    CategoryTab value,
    this.categoryTabStatus,
    this.categoryTabViewStatus,
    this.itemCount,
    ScrollView listBody,
  )   : sysStoreCategoryId = value.sysStoreCategoryId,
        isSpecials = value.isSpecials,
        super(
          listTab: ListTab(
              text: value.listTab.text,
            ),
          listBody: listBody);

  final String sysStoreCategoryId;
  final CategoryTabStatus categoryTabStatus;
  final CategoryTabViewStatus categoryTabViewStatus;
  final bool isSpecials;
  final int itemCount;

  bool get doNotShow => categoryTabStatus == CategoryTabStatus.loaded && itemCount == 0;
}
