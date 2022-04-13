import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/infrastructure/progress_error_state_type.dart';
import 'package:single_store_app/src/app/models/infrastructure/data_direction.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_event.dart';
import 'package:single_store_app/src/app/widgets/error/progress_error_widget.dart';
import 'package:single_store_app/src/app/widgets/ui/splash_widget.dart';

import 'initial_bloc.dart';
import 'initial_event.dart';
import 'initial_state.dart';

class InitialView extends StatefulWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  bool _initialised = false;
  late InitialBloc initialBloc;

  @override
  void didChangeDependencies() {
    final initialBloc = BlocProvider.of<InitialBloc>(context);

    if (!_initialised) {
      _initialised = true;
      this.initialBloc = initialBloc;
      _initialise();
    } else {
      if (this.initialBloc != initialBloc) {
        this.initialBloc = initialBloc;
        _initialise();
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InitialBloc, InitialState>(builder: (context, state) {
        return _view(state);
      }),
    );
  }

  void _initialise() {
    initialBloc.add(InitialEventLoad());
  }

  Widget _view(InitialState state) {
    switch (state.type) {
      case ProgressErrorStateType.initial:
      case ProgressErrorStateType.idle:
      case ProgressErrorStateType.submitted:
        {
          return const SplashWidget();
        }

      case ProgressErrorStateType.loadingError:
      case ProgressErrorStateType.progressError:
        {
          return ProgressErrorWidget(
            progressErrorState: state,
            dataDirection: DataDirection.none,
            tryAgainCallback: () =>
                context.read<InitialBloc>().add(InitialEventLoad()),
            progressWidget: const SplashWidget(),
          );
        }

      case ProgressErrorStateType.loaded:
        {
          context.read<BusinessSelectBloc>().add(BusinessSelectEventLoad(
              initialStateLoaded: state as InitialStateLoaded));

          return const SplashWidget();
        }
    }
  }
}
