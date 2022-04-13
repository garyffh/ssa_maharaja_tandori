import 'package:flutter/cupertino.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/infrastructure/progress_view_state.dart';

@immutable
abstract class {{#pascalCase}}{{name}}{{/pascalCase}}State extends ProgressViewState {
  const {{#pascalCase}}{{name}}{{/pascalCase}}State({
    required ProgressErrorStateType type,
    dynamic error,
  }) : super(type: type, error: error);
}

class {{#pascalCase}}{{name}}{{/pascalCase}}StateIdle extends {{#pascalCase}}{{name}}{{/pascalCase}}State {
  const {{#pascalCase}}{{name}}{{/pascalCase}}StateIdle()
      : super(
          type: ProgressErrorStateType.idle,
        );
}

class {{#pascalCase}}{{name}}{{/pascalCase}}StateProgressError extends {{#pascalCase}}{{name}}{{/pascalCase}}State {
  const {{#pascalCase}}{{name}}{{/pascalCase}}StateProgressError({
    dynamic error,
  }) : super(
          type: ProgressErrorStateType.progressError,
          error: error,
        );
}
