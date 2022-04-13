import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

import 'initial_bloc.dart';
import 'initial_repo.dart';
import 'initial_view.dart';

class InitialModule extends StatelessWidget {
  const InitialModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return RepositoryProvider(
      create: (context) => InitialRepo(
        appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
      ),
      child: BlocProvider(
        create: (context) =>
            InitialBloc(
                initialRepo: RepositoryProvider.of<InitialRepo>(context)),
        child: const InitialView(),
      ),
    );
  }
}

