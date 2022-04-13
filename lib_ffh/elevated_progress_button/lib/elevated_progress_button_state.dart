import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ProgressButtonState { idle, progress, success, fail }

class ElevatedProgressButtonState {
  ElevatedProgressButtonState({
    required this.progressButtonState,
    this.text,
    this.icon,
    required this.spacing,
  });

  final ProgressButtonState progressButtonState;
  final String? text;
  final Icon? icon;
  final double spacing;

  bool get hasProgressWidget => text != null && text!.trim().isNotEmpty;

  Widget uiState() {
    final children = List<Widget>.empty(growable: true);

    if (progressButtonState == ProgressButtonState.progress) {
      if (text != null && text!.trim().isNotEmpty) {
        children.add(Padding(padding: EdgeInsets.symmetric(horizontal: spacing)));
        children.add(Text(text!));
      } else {
        children.add(const SizedBox.shrink());
      }
    } else {

      if (icon != null) {
        children.add(icon!);
      }

      if (icon != null && text != null && text!.trim().isNotEmpty) {
         children.add(Padding(padding: EdgeInsets.symmetric(horizontal: spacing)));
      }

      if (text != null && text!.trim().isNotEmpty) {

        children.add(Text(text!));
      }

    }

    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );

  }
}
