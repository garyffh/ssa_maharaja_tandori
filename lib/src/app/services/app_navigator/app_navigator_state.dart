import 'package:flutter/cupertino.dart';

@immutable
class AppNavigatorState {
  const AppNavigatorState({
    required this.dialogCount,
    required this.navigatorKey,
  });

  AppNavigatorState.initial()
      : dialogCount = 0,
        navigatorKey = GlobalKey<NavigatorState>();

  AppNavigatorState.incrementDialogCount(AppNavigatorState appNavigatorState)
      : dialogCount = appNavigatorState.dialogCount + 1,
        navigatorKey = appNavigatorState.navigatorKey;

  AppNavigatorState.decrementDialogCount(AppNavigatorState appNavigatorState)
      : dialogCount = appNavigatorState.dialogCount - 1,
        navigatorKey = appNavigatorState.navigatorKey;

  final GlobalKey<NavigatorState> navigatorKey;
  final int dialogCount;
}
