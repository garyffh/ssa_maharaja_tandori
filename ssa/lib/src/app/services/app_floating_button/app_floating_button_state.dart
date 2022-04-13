import 'package:flutter/material.dart';

@immutable
abstract class AppFloatingButtonState {
  const AppFloatingButtonState({
    required this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
  });

  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
}

class AppFloatingButtonStateInactive extends AppFloatingButtonState {
  const AppFloatingButtonStateInactive() : super(floatingActionButton: null);
}

class AppFloatingButtonStateActive extends AppFloatingButtonState {
  const AppFloatingButtonStateActive({
    required Widget floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation =
        FloatingActionButtonLocation.endFloat,
  }) : super(
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );

  AppFloatingButtonStateActive.fromFloatingActionButtons({
    required List<Widget> buttons,
    FloatingActionButtonLocation floatingActionButtonLocation =
        FloatingActionButtonLocation.endFloat,
  }) : super(
          floatingActionButton: floatingButtonsWidget(buttons),
          floatingActionButtonLocation: floatingActionButtonLocation,
        );

  static Widget floatingButtonsWidget(List<Widget> buttons) {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(buttons.length, (index) => buttons[index]),
    );
  }
}
