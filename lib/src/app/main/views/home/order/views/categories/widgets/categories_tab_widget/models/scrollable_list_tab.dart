import 'package:flutter/material.dart';
import 'list_tab.dart';

class ScrollableListTab {
  ScrollableListTab({
    required this.listTab,
    required this.listBody,
  }) : assert(listBody.shrinkWrap && listBody.physics is NeverScrollableScrollPhysics);

  final ListTab listTab;
  final ScrollView listBody;
}
