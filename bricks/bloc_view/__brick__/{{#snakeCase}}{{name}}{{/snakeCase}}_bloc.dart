import 'package:flutter_bloc/flutter_bloc.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}Bloc
    extends Bloc<{{#pascalCase}}{{name}}{{/pascalCase}}Event, {{#pascalCase}}{{name}}{{/pascalCase}}State> {
{{#pascalCase}}{{name}}{{/pascalCase}}Bloc({
  }) : super(const {{#pascalCase}}{{name}}{{/pascalCase}}StateIdle());

  final AuthenticationRepo authenticationRepo;
  final AuthenticateNavCubit authenticateNavCubit;

  @override
  Stream<{{#pascalCase}}{{name}}{{/pascalCase}}State> mapEventToState(
{{#pascalCase}}{{name}}{{/pascalCase}}Event event) async* {
    switch (event.runtimeType) {
      case {{#pascalCase}}{{name}}{{/pascalCase}}EventSubmit:
        {
          yield const {{#pascalCase}}{{name}}{{/pascalCase}}StateProgressError();

          try {
            final {{#pascalCase}}{{name}}{{/pascalCase}}EventSubmit submitEvent =
                event as {{#pascalCase}}{{name}}{{/pascalCase}}EventSubmit;

            yield const {{#pascalCase}}{{name}}{{/pascalCase}}StateIdle();
          }  catch (e) {
            yield {{#pascalCase}}{{name}}{{/pascalCase}}StateProgressError(error: e);
          }

          break;
        }

      case {{#pascalCase}}{{name}}{{/pascalCase}}EventResetError:
        {
          yield const {{#pascalCase}}{{name}}{{/pascalCase}}StateIdle();

          break;
        }
    }
  }
}
