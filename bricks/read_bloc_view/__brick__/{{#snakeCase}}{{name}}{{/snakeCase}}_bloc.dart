import 'package:flutter_bloc/flutter_bloc.dart';

import '{{#snakeCase}}{{name}}{{/snakeCase}}_event.dart';
import '{{#snakeCase}}{{name}}{{/snakeCase}}_state.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}Bloc
    extends Bloc<{{#pascalCase}}{{name}}{{/pascalCase}}Event, {{#pascalCase}}{{name}}{{/pascalCase}}State> {
  {{#pascalCase}}{{name}}{{/pascalCase}}Bloc({
    required this.{{#camelCase}}{{repo}}{{/camelCase}}Repo,
  }) : super(const {{#pascalCase}}{{name}}{{/pascalCase}}StateInitial());

  final {{#pascalCase}}{{repo}}{{/pascalCase}}Repo {{#camelCase}}{{repo}}{{/camelCase}}Repo;

  @override
  Stream<{{#pascalCase}}{{name}}{{/pascalCase}}State> mapEventToState(
      {{#pascalCase}}{{name}}{{/pascalCase}}Event event) async* {
    switch (event.runtimeType) {
      case {{#pascalCase}}{{name}}{{/pascalCase}}EventGetViewModel:
        {
          try {

            yield const {{#pascalCase}}{{name}}{{/pascalCase}}StateLoadingError();

            // yield {{#pascalCase}}{{name}}{{/pascalCase}}StateViewModel(
            //  payload: await {{#camelCase}}{{repo}}{{/camelCase}}Repo.find{{#pascalCase}}{{name}}{{/pascalCase}}(),
            // );

            yield const {{#pascalCase}}{{name}}{{/pascalCase}}StateViewModel(
              payload: Object(),
            );


          } catch (e) {
            yield {{#pascalCase}}{{name}}{{/pascalCase}}StateLoadingError(error: e);
          }
          break;
        }


    }
  }
}
