import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/repos/driver/driver_repo.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';
import 'package:single_store_app/src/app/services/app_repo_base/app_repo_cubit.dart';

import 'driver_route.dart';

class DriverModule extends StatelessWidget {
  const DriverModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DriverRepo>(
          create: (context) => DriverRepo(
            appRepoCubit: BlocProvider.of<AppRepoCubit>(context),
          ),
        ),
      ],
      child: DriverRoute(
        appFloatingButtonCubit: BlocProvider.of<AppFloatingButtonCubit>(context),
      ),
    );
  }
}
