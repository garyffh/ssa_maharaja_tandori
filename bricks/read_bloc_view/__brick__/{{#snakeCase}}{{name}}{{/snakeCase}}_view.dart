import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/extensions/text_style_extensions.dart';
import 'package:single_store_app/src/app/infrastructure/formats.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/error/unhandled_state_widget.dart';
import 'package:single_store_app/src/app/widgets/view/sub_view.dart';


import '{{#snakeCase}}{{name}}{{/snakeCase}}_bloc.dart';
import '{{#snakeCase}}{{name}}{{/snakeCase}}_event.dart';
import '{{#snakeCase}}{{name}}{{/snakeCase}}_state.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}View extends StatelessWidget {
  const {{#pascalCase}}{{name}}{{/pascalCase}}View({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{#pascalCase}}{{name}}{{/pascalCase}}Bloc(
        {{#camelCase}}{{repo}}{{/camelCase}}Repo: context.read<{{#pascalCase}}{{repo}}{{/pascalCase}}Repo>(),
      )..add({{#pascalCase}}{{name}}{{/pascalCase}}EventGetViewModel()),
      child: BlocBuilder<{{#pascalCase}}{{name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{name}}{{/pascalCase}}State>(
        builder: (viewContext, state) {
          return SubView(
            title: '{{#upperCase}}{{name}}{{/upperCase}}',
            child: _view(viewContext, state),
          );
        },
      ),
    );
  }

  Widget _view(BuildContext viewContext, {{#pascalCase}}{{name}}{{/pascalCase}}State viewState) {
    switch (viewState.type) {
      case ProgressErrorStateType.loaded:
        {
          return _viewModel(
              viewContext, viewState as {{#pascalCase}}{{name}}{{/pascalCase}}StateViewModel);
        }

      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.loadingError:
        {
          return ProgressErrorWidget(
            progressErrorState: viewState,
            dataDirection: DataDirection.receiving,
            tryAgainCallback: () => viewContext
                .read<{{#pascalCase}}{{name}}{{/pascalCase}}Bloc>()
                .add({{#pascalCase}}{{name}}{{/pascalCase}}EventGetViewModel()),
          );
        }

      case ProgressErrorStateType.progressError:
      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const UnhandledStateWidget();
        }
    }
  }

  Widget _viewModel(
      BuildContext context,
      {{#pascalCase}}{{name}}{{/pascalCase}}StateViewModel viewModel,
      ) {
    return Container(
      padding:
      EdgeInsets.all(context.watch<MediaSettingsBloc>().state.formPadding),
      child: const Text('View Model'),
    );
  }
}
