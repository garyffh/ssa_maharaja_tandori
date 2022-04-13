import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';

import 'my_account_nav_cubit.dart';
import 'my_account_route.dart';

class MyAccountModule extends StatelessWidget {
  const MyAccountModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MyAccountNavCubit(),
          ),
        ],
        child: MyAccountRoute(
          appFloatingButtonCubit: BlocProvider.of<AppFloatingButtonCubit>(context),
        ),
    );
  }
}
