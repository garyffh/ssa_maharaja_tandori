import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/main/main_module.dart';
import 'package:single_store_app/src/app/select/select_module.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_bloc.dart';
import 'package:single_store_app/src/app/services/business_select/business_select_state.dart';
import 'initial/initial_module.dart';

class AppRoute extends StatelessWidget {
  const AppRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BusinessSelectBloc, BusinessSelectState>(
      builder: (context, state) {
        switch (state.type) {
          case BusinessSelectStateType.pending:
            return const InitialModule();

          case BusinessSelectStateType.loaded:
            return const SelectModule();

          case BusinessSelectStateType.selected:
            return const MainModule();

        }
      },
    );
  }
}
