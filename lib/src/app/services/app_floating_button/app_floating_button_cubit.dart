import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_floating_button_state.dart';

class AppFloatingButtonCubit extends Cubit<AppFloatingButtonState> {
  AppFloatingButtonCubit() : super(const AppFloatingButtonStateInactive());

  void showFloatingButton({
    required FloatingActionButton floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation =
        FloatingActionButtonLocation.endFloat,
  }) {
    emit(AppFloatingButtonStateActive(
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation));
  }

  void showFloatingButtons({
    required List<Widget> buttons,
    FloatingActionButtonLocation floatingActionButtonLocation =
        FloatingActionButtonLocation.endFloat,
  }) {
    emit(AppFloatingButtonStateActive.fromFloatingActionButtons(
        buttons: buttons,
        floatingActionButtonLocation: floatingActionButtonLocation));
  }

  void removeFloatingButton() {
    emit(const AppFloatingButtonStateInactive());
  }
}
