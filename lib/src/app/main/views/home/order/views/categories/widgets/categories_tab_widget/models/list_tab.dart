import 'package:flutter/material.dart';
import 'package:single_store_app/src/app/main/views/home/order/views/categories/widgets/categories_tab_widget/widgets/list_header_widget.dart';

class ListTab {
  ListTab({
    required this.text,
  }) {
    tabLabel = Text(text);
  }

  final String text;
  late Widget tabLabel;

  Widget listWidget(bool doNotShow) => doNotShow
      ? const SizedBox(
          width: double.infinity,
          height: 1,
        )
      : ListHeaderWidget(category: text);
}
