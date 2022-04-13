import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';

@immutable
abstract class {{#pascalCase}}{{name}}{{/pascalCase}}State extends ProgressErrorState {
  const {{#pascalCase}}{{name}}{{/pascalCase}}State({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class {{#pascalCase}}{{name}}{{/pascalCase}}StateInitial extends {{#pascalCase}}{{name}}{{/pascalCase}}State {
  const {{#pascalCase}}{{name}}{{/pascalCase}}StateInitial()
      : super(
    type: ProgressErrorStateType.initial,
  );
}

class {{#pascalCase}}{{name}}{{/pascalCase}}StateLoadingError extends {{#pascalCase}}{{name}}{{/pascalCase}}State {
  const {{#pascalCase}}{{name}}{{/pascalCase}}StateLoadingError({
    dynamic error,
  }) : super(
    type: ProgressErrorStateType.loadingError,
    error: error,
  );
}

class {{#pascalCase}}{{name}}{{/pascalCase}}StateViewModel extends {{#pascalCase}}{{name}}{{/pascalCase}}State {
  const {{#pascalCase}}{{name}}{{/pascalCase}}StateViewModel({
    required this.payload,
  }) : super(
    type: ProgressErrorStateType.loaded,
  );

  final Object payload;
}
