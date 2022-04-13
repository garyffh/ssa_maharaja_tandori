import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/select/select_bloc.dart';
import 'package:single_store_app/src/app/select/select_state.dart';
import 'package:single_store_app/src/app/select/views/store_select/store_select_view.dart';

class SelectRoute extends StatelessWidget {
  const SelectRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SelectBloc, SelectState>(
        builder: (context, state) {
      return Navigator(
        pages: [
          if (state.runtimeType == SelectStateSelect)
            const MaterialPage<StoreSelectView>(
              child: StoreSelectView(),
              ),
        ],
        onPopPage: (route, dynamic result) => route.didPop(result),
      );
    });
  }
}
