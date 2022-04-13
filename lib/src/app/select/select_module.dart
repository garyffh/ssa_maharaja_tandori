import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/select/select_bloc.dart';
import 'package:single_store_app/src/app/select/select_route.dart';

class SelectModule extends StatelessWidget {
  const SelectModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SelectBloc()),
      ],
      child: const SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          body: SelectRoute(),
        ),
      ),
    );
  }
}
