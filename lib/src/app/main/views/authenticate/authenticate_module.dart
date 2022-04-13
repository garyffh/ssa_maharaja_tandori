
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/app_floating_button/app_floating_button_cubit.dart';

import 'authenticate_route.dart';

class AuthenticateModule extends StatelessWidget {
  const AuthenticateModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticateRoute(
      appFloatingButtonCubit: BlocProvider.of<AppFloatingButtonCubit>(context),
    );
  }
}
