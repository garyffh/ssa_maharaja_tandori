class TabBuildResult {

  TabBuildResult({
    required this.updateTabs,
    required this.errorTabIndex,
    required this.scrollBodyIndex,
  });

  final bool updateTabs;
  final int errorTabIndex;
  final int scrollBodyIndex;
}
