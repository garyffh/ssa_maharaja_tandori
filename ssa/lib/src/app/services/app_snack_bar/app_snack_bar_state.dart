import 'package:flutter/material.dart';

@immutable
abstract class AppSnackBarState {
  const AppSnackBarState({
    this.snackBar,
  });

  final SnackBar? snackBar;

}

class AppSnackBarStateInitial extends AppSnackBarState {
  const AppSnackBarStateInitial() : super();
}

class AppSnackBarStatePublished extends AppSnackBarState {
  const AppSnackBarStatePublished({
    required SnackBar snackBar,
  }) : super( snackBar: snackBar);

}
